# Ошибки WeatherApp — Перекрёстный анализ с чатом ментора

Дата анализа: 01.06.2026
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

**Где:** `lib/main.dart:17`

```dart
late final AppLocalizations strings;
```

---

### 8. `if (result.error == null)` вместо `if (result.isSuccess)` в API

**Где:**
- `lib/network/weather/weather_api.dart:39`
- `lib/network/geocoding/geocoding_api.dart:34, 79`

```dart
if (result.error == null) {       // ← должно быть if (result.isSuccess)
```

**Fix:** success-first паттерн, как в репозитории и контроллере.

---

### 9. `register(GetIt)` — dead code (все зависимости через конструкторы)

**Где:** `lib/main.dart:38, 44, 52, 59, 64, 73` — все вызовы `.register(getIt)`

**Проблема:** каждый объект регистрируется в GetIt, но нигде не запрашивается через `getIt<Type>()`. Регистрация не используется.

---

### 10. `GeocodingApi.getCoordinates()` возвращает `Map<String, double>`

**Где:** `lib/network/geocoding/geocoding_api.dart:42-47`

```dart
return WeatherResult.success({
  'lat': response.lat ?? 0.0,
  'lon': response.lon ?? 0.0,
});
```

**Fix:** создать модель `Coordinates` с полями `lat`/`lon` и использовать её.

---

## 📋 ОСТАЛОСЬ

| # | Степень | Описание | Файл |
|---|---------|----------|------|
| 1 | 🔴 HIGH | `Colors.red` вместо AppColors | ~~weather_map_widget.dart~~ ✅ |
| 2 | 🟡 MED | static `_getIt` поля | ~~weather_api.dart, geocoding_api.dart, weather_repository.dart~~ ✅ |
| 3 | 🟡 MED | `getInstance()` статический метод | ~~weather_repository.dart~~ ✅ |
| 4 | 🟡 MED | AppImages пустой | app_images.dart |
| 5 | 🟡 MED | Нет тестов | test/ |
| 6 | 🟡 MED | API key хардкодом | app_config.dart |
| 7 | 🟢 LOW | Глобальная `strings` | main.dart |
| 8 | 🟡 MED | `if (result.error == null)` вместо `if (result.isSuccess)` | ~~weather_api.dart, geocoding_api.dart~~ ✅ |
| 9 | 🟡 MED | `register(GetIt)` — dead code | main.dart |
| 10 | 🟡 MED | `getCoordinates()` возвращает raw Map | geocoding_api.dart |

---

## 🔧 ИСПРАВЛЕНО В ЭТОЙ СЕССИИ

| # | Было | Стало |
|---|------|-------|
| 1 | `loadForecastByCity` вызывал `loadForecast`, затирая координаты GPS | Вызывает `_repository.fetchForecast()` напрямую |
| 2 | Дублирование WeatherNetwork / GeocodingNetwork (2 × 96 строк) | NetworkService + 2 наследника по 18 строк |
| 3 | Бесполезный `get<T>()` с `if (data is T)` | `get()` возвращает `WeatherResult<dynamic>` |
| 4 | Domain model зависит от network model | Конвертация в репозитории, модель чистая |
| 5 | `Colors.red` вместо AppColors | `AppColors.error` |
| 6 | `new LocationService()` в контроллере | Через конструктор |
| 11 | WeatherNetwork без appid, GeocodingNetwork с appid | `NetworkService.get()` всегда добавляет `appid` |
| — | Названия `forecast` в файлах/классах | Переименовано в `weather` |
| — | Example: `fromNetworkModel` в `RateData` | Конвертация в API-слое |
| 8 | `if (result.error == null)` в API | `if (result.isSuccess)` ✅ |
| — | `if (result.isError)` в репозитории и контроллере | success-first ✅ |
