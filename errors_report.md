# Ошибки WeatherApp — Перекрёстный анализ с чатом ментора

Дата анализа: 28.05.2026
Источник: чат с дима snake (12.03.2026 — 25.05.2026, файлы messages1–8.html)
Проект: WeatherApp (lib/, test/, example/)

---

## 🔴 ВЫСОКАЯ СТЕПЕНЬ

### 1. `Colors.red` вместо AppColors

**Где:** `lib/ui/home/widgets/weather_map_widget.dart:104`

```dart
child: const Icon(
  Icons.location_pin,
  color: Colors.red,    // ← должно быть AppColors.error или AppColors.primary
  size: 40,
),
```

**Импорт AppColors уже есть** на строке 6.

---

## 🟡 СРЕДНЯЯ СТЕПЕНЬ

### 2. static `_getIt` в WeatherApi, GeocodingApi, WeatherRepository

**Где:**
- `lib/network/weather/weather_api.dart:10`
- `lib/network/geocoding/geocoding_api.dart:9`
- `lib/repository/weather_repository.dart:12`

```dart
static final GetIt _getIt = GetIt.instance;
```

**Проблема:** статическое поле `_getIt` создаёт скрытую зависимость от глобального состояния. Затрудняет тестирование.

### 3. `getInstance()` — статический метод для получения репозитория

**Где:**
- `lib/repository/weather_repository.dart:32` — `static WeatherRepository getInstance()`
- `lib/ui/home/home_controller.dart:10` — вызов `WeatherRepository.getInstance()`

### 4. AppImages — пустой файл

**Где:** `lib/resources/images/app_images.dart`

```dart
class AppImages {
  // static const _baseImagePath = 'assets/images';
}
```

### 5. Нет тестов

**Где:** `test/` — пустая директория, 0 файлов

### 6. API key хардкодом

**Где:** `lib/config/app_config.dart:2`

```dart
static const String apiKey = 'eb404837e936b57aae44c7b14cb5a83b';
```

**Fix:** использовать `--dart-define`:
```dart
class AppConfig {
  static const String apiKey = String.fromEnvironment('WEATHER_API_KEY');
}
```

---

## 🟢 НИЗКАЯ СТЕПЕНЬ / СТИЛЬ

### 7. Глобальная переменная `strings`

**Где:** `lib/main.dart:15`

```dart
late final AppLocalizations strings;
```

---

## 📋 ОСТАЛОСЬ (7 ошибок)

| # | Степень | Описание | Файл |
|---|---------|----------|------|
| 1 | 🔴 HIGH | `Colors.red` вместо AppColors | weather_map_widget.dart |
| 2 | 🟡 MED | static `_getIt` поля | weather_api.dart, geocoding_api.dart, weather_repository.dart |
| 3 | 🟡 MED | `getInstance()` статический метод | weather_repository.dart |
| 4 | 🟡 MED | AppImages пустой | app_images.dart |
| 5 | 🟡 MED | Нет тестов | test/ |
| 6 | 🟡 MED | API key хардкодом | app_config.dart |
| 7 | 🟢 LOW | Глобальная `strings` | main.dart |

---

## 🔧 ИСПРАВЛЕНО В ЭТОЙ СЕССИИ

| # | Было | Стало |
|---|------|-------|
| 1 | `loadForecastByCity` вызывал `loadForecast`, затирая координаты GPS | Вызывает `_repository.fetchForecast()` напрямую |
| 2 | Дублирование WeatherNetwork / GeocodingNetwork (2 × 96 строк) | NetworkService + 2 наследника по 18 строк |
| 3 | Бесполезный `get<T>()` с `if (data is T)` | `get()` возвращает `WeatherResult<dynamic>` |
| 4 | Domain model зависит от network model | Конвертация в репозитории, модель чистая |
| 6 | `new LocationService()` в контроллере | Через `_getIt<LocationService>()` |
| 12 | WeatherNetwork без appid, GeocodingNetwork с appid | `NetworkService.get()` всегда добавляет `appid` |
| — | Названия `forecast` в файлах/классах | Переименовано в `weather` |
| — | Example: `fromNetworkModel` в `RateData` | Конвертация в API-слое |
