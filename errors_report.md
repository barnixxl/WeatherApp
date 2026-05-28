# Ошибки WeatherApp — Перекрёстный анализ с чатом ментора

Дата анализа: 28.05.2026
Источник: чат с дима snake (12.03.2026 — 25.05.2026, файлы messages1–8.html)
Проект: WeatherApp (lib/, test/, example/)

---

## ⚠ КРИТИЧЕСКИЕ БАГИ

### 1. `loadForecastByCity()` → `loadForecast()` → `_loadCurrentLocation()` затирает координаты города

**Где:** `lib/ui/home/home_controller.dart:48–80`

**Что происходит:**
1. `loadForecastByCity("London")` получает координаты Лондона, сохраняет в `_latitude`/`_longitude`
2. На строке 78 вызывает `await loadForecast()`
3. `loadForecast()` (строка 30) вызывает `await _loadCurrentLocation()` (строка 36)
4. `_loadCurrentLocation()` (строка 82) **перезаписывает** `_latitude`/`_longitude` координатами GPS
5. Итог: на UI отображается название города, который искал пользователь (`_cityName` сохранён), но погода загружена для GPS-позиции

**Связь с чатом:** в чате не обсуждался, самостоятельно найден.

**Fix:** `loadForecastByCity()` должен вызывать `_repository.fetchForecast()` напрямую, минуя `loadForecast()`.

```dart
// Было (строка 78):
await loadForecast();

// Должно быть:
final result = await _repository.fetchForecast(
  _latitude.value,
  _longitude.value,
);
runInAction(() {
  _forecastResult.value = result;
});
```

---

## 🔴 ВЫСОКАЯ СТЕПЕНЬ

### 2. ~~Дублирование кода: WeatherNetwork и GeocodingNetwork — 95% идентичны~~ ✅ ИСПРАВЛЕНО

**Было:** два отдельных класса `WeatherNetwork` (forecast_network.dart) и `GeocodingNetwork` (geocoding_network.dart) с 95% дублированием.

**Стало:** единый `NetworkService` в `lib/network/network_service.dart`. Оба API (`ForecastApi`, `GeocodingApi`) используют его через `_getIt<NetworkService>()`, передавая полный URL. Дублирование устранено.

### 3. ~~Бесполезный generic `<T>` в `get<T>()`~~ ✅ ИСПРАВЛЕНО

**Было:** `Future<WeatherResult<T>> get<T>(...)` с проверкой `if (data is T)` — бесполезно, т.к. `T` всегда выводится как `dynamic`.

**Стало:** `Future<WeatherResult<dynamic>> get(...)` — без generic, возвращает сырой `response.data`. Парсинг формата (Map, List) — ответственность API-слоя.

### 4. Domain model зависит от network model

**Где:** `lib/models/weather_data.dart:1`

**Проблема:**
```dart
import '../network/forecast/resp/forecast_item_from_network.dart';

class WeatherData {
  ...
  static WeatherData fromNetworkModel(ForecastItemFromNetwork model) { ... }
}
```

- Domain-слой (`models/`) импортирует network-слой — нарушение слоистой архитектуры
- Конвертация должна быть в repository или в самом network-слое, но не в model

**Аналогичная проблема в example:** `example/models/rate_data.dart` имеет `static RateData fromNetworkModel(RateDataFromNetwork model)` — тот же паттерн.

**Fix:** убрать метод из `WeatherData`, перенести конвертацию в `WeatherRepository.fetchForecast()` (где она уже используется на строке 57). `WeatherData` не должен знать о `ForecastItemFromNetwork`.

### 5. `Colors.red` вместо AppColors

**Где:** `lib/ui/home/widgets/weather_map_widget.dart:104`

```dart
child: const Icon(
  Icons.location_pin,
  color: Colors.red,    // ← должно быть AppColors.error или AppColors.primary
  size: 40,
),
```

**Импорт AppColors уже есть** на строке 6.

### 6. LocationService не зарегистрирован в GetIt

**Где:**
- `lib/utils/location_service.dart` — класс без `register(GetIt)`
- `lib/ui/home/home_controller.dart:11` — прямой new

**Проблема:**
```dart
final LocationService _locationService = LocationService();  // ← не через DI
```

Весь остальной проект использует GetIt для DI. LocationService — единственное исключение.

---

## 🟡 СРЕДНЯЯ СТЕПЕНЬ

### 7. static `_getIt` в ForecastApi, GeocodingApi, WeatherRepository

**Где:**
- `lib/network/forecast/forecast_api.dart:10`
- `lib/network/geocoding/geocoding_api.dart:9`
- `lib/repository/weather_repository.dart:12`

```dart
static final GetIt _getIt = GetIt.instance;
```

**Проблема:** статическое поле `_getIt` создаёт скрытую зависимость от глобального состояния. Это затрудняет тестирование и переиспользование.

**Примечание:** в example та же проблема. Это устоявшийся паттерн во всём проекте.

### 8. `getInstance()` — статический метод для получения репозитория

**Где:**
- `lib/repository/weather_repository.dart:32` — `static WeatherRepository getInstance()`
- `lib/ui/home/home_controller.dart:10` — вызов `WeatherRepository.getInstance()`

Этот метод перекладывает ответственность за DI на потребителя, а не на фреймворк.

### 9. AppImages — пустой файл

**Где:** `lib/resources/images/app_images.dart`

**Содержимое:**
```dart
class AppImages {
  // static const _baseImagePath = 'assets/images';
}
```

- `assets/images/` объявлен в pubspec.yaml, но не используется
- Нет файлов изображений в директории

### 10. Нет тестов

**Где:** `test/` — пустая директория, 0 файлов

- Нет unit-тестов для `HomeController`, `WeatherRepository`, моделей
- Нет widget-тестов для экранов
- Нет тестов для network слоя

### 11. API key хардкодом

**Где:** `lib/config/app_config.dart:2`

```dart
static const String apiKey = 'eb404837e936b57aae44c7b14cb5a83b';
```

- Ключ виден в коде, попадает в git
- Невозможно менять без пересборки

**Fix:** использовать `--dart-define`:
```dart
class AppConfig {
  static const String apiKey = String.fromEnvironment('WEATHER_API_KEY');
}
```

---

## 🟢 НИЗКАЯ СТЕПЕНЬ / СТИЛЬ

### 12. ~~Несоответствие: WeatherNetwork.get() НЕ добавляет appid, GeocodingNetwork.get() ДОБАВЛЯЕТ~~ ✅ ИСПРАВЛЕНО

**Было:** `WeatherNetwork.get()` — без appid, `GeocodingNetwork.get()` — с appid.

**Стало:** единый `NetworkService.get()` всегда добавляет `appid`. Оба API получают ключ автоматически.

### 13. Глобальная переменная `strings`

**Где:** `lib/main.dart:15`

```dart
late final AppLocalizations strings;
```

- Зависит от порядка инициализации (должна быть проинициализирована до использования)
- Pattern скопирован из example

### 14. Example проект — те же ошибки

- `example/models/rate_data.dart` — `fromNetworkModel` (domain → network)
- `example/ui/home/home_controller.dart` — `CurrencyRepository.getInstance()` (статический доступ)
- `example/network/currency_rate_network.dart` — generic `<T>` бесполезен
- `example/network/currency/currency_api.dart` — `static final GetIt _getIt`

---

## ✅ ЧТО СДЕЛАНО ПРАВИЛЬНО

- Observer в home_screen.dart, НЕ внутри part-файлов ✓
- Навигация в home_screen.dart, НЕ внутри part-файлов ✓
- `void Function()` вместо `VoidCallback` ✓
- Callback именование `onRetryPressed` ✓
- Part-файлы для разных состояний экрана ✓
- Минимальные входные параметры в part-файлы ✓
- try/catch с DioException в network слое ✓
- Trailing commas в основном везде ✓
- `main()` async с `WidgetsFlutterBinding.ensureInitialized()` ✓
- `WeatherResult` — простой класс (не sealed) ✓
- `WeatherError.errorMessage` вместо `message` ✓
- Строки через `strings.xxx` из l10n ✓
- `register(GetIt) / initializeDependencies()` паттерн ✓
- `getInstance()` статический метод через GetIt ✓

---

## 📋 СВОДНАЯ ТАБЛИЦА

| # | Степень | Описание | Файл | Строка |
|---|---------|----------|------|--------|
| 1 | ⚠ CRIT | `loadForecastByCity` вызывает `loadForecast`, который затирает координаты GPS | home_controller.dart | 78 |
| 2 | 🔴 HIGH | ~~Дублирование WeatherNetwork / GeocodingNetwork~~ ✅ | ForecastNetworkService / GeocodingNetworkService | — |
| 3 | 🔴 HIGH | ~~Бесполезный generic `<T>` в get~~ ✅ | network_service.dart | — |
| 4 | 🔴 HIGH | Domain model зависит от network model | weather_data.dart | 1, 22 |
| 5 | 🔴 HIGH | `Colors.red` вместо AppColors | weather_map_widget.dart | 104 |
| 6 | 🔴 HIGH | LocationService не в GetIt | location_service.dart / home_controller.dart | 11 |
| 7 | 🟡 MED | static `_getIt` поля | forecast_api.dart, geocoding_api.dart, weather_repository.dart | 10, 9, 12 |
| 8 | 🟡 MED | `getInstance()` статический метод | weather_repository.dart | 32 |
| 9 | 🟡 MED | AppImages пустой | app_images.dart | весь файл |
| 10 | 🟡 MED | Нет тестов | test/ | — |
| 11 | 🟡 MED | API key хардкодом | app_config.dart | 2 |
| 12 | 🟢 LOW | ~~Несоответствие appid в network~~ ✅ | network_service.dart | — |
| 13 | 🟢 LOW | Глобальная `strings` | main.dart | 15 |
| 14 | 🟢 LOW | Example: те же ошибки | example/ | — |
