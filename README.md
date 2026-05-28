# Weather App

Приложение для прогноза погоды на Flutter с использованием OpenWeatherMap API.

## Архитектура

Проект построен на основе **MVVM** паттерна с жесткой декомпозицией:

- **Models** - модели данных (WeatherData, DayForecast, WeatherResult, WeatherError)
- **Network** - сетевой слой (Dio, API endpoints, response модели)
- **Repository** - репозитории для работы с данными
- **UI** - пользовательский интерфейс (screens, controllers, widgets)
- **Resources** - ресурсы (colors, images, strings/локализация)
- **Utils** - утилиты (форматирование дат, маппинг иконок)

## Технологический стек

- **State Management**: MobX + flutter_mobx
- **Dependency Injection**: GetIt
- **Network**: Dio
- **JSON Serialization**: json_annotation + json_serializable
- **Localization**: flutter_localizations + intl
- **Maps**: flutter_map + latlong2
- **Location**: geolocator

## Структура проекта

```
lib/
├── main.dart                          # Точка входа, инициализация DI
├── models/                            # Модели данных
│   ├── weather_error.dart
│   ├── weather_result.dart
│   ├── weather_data.dart
│   └── day_forecast.dart
├── network/                           # Сетевой слой
│   ├── weather_network.dart           # Базовый Dio клиент
│   └── weather/
│       ├── weather_api.dart           # API методы
│       └── resp/                      # Response модели
│           ├── forecast_item_from_network.dart
│           ├── forecast_response_from_network.dart
│           └── geocoding_response_from_network.dart
├── repository/                        # Репозитории
│   ├── base_repository.dart
│   └── weather_repository.dart
├── resources/                         # Ресурсы
│   ├── colors/
│   │   └── app_colors.dart
│   ├── images/
│   │   └── app_images.dart
│   └── strings/                       # Локализация (генерируется)
│       ├── app_localizations.dart
│       └── app_localizations_ru.dart
├── ui/                                # UI слой
│   └── home/
│       ├── home_controller.dart       # MobX контроллер
│       ├── home_screen.dart           # Главный экран
│       ├── home_screen.app_bar_state.part.dart
│       ├── home_screen.error_state.part.dart
│       ├── home_screen.load_state.part.dart
│       ├── home_screen.success_state.part.dart
│       └── widgets/
│           ├── day_forecast_item.dart
│           ├── hourly_forecast_row.dart
│           └── weather_map_widget.dart
└── utils/                             # Утилиты
    ├── date_formatter.dart
    └── weather_icon_mapper.dart
```

## Особенности реализации

### 1. Прогноз погоды
- Прогноз на 5 дней с данными каждые 2 часа
- Группировка по дням недели
- Отображение температуры, иконки погоды и времени
- Горизонтальный скролл для почасового прогноза

### 2. Карта
- Отображение текущего местоположения на карте
- Маркер с координатами города
- Интеграция с OpenStreetMap

### 3. API
- **5 Day / 3 Hour Forecast API** - прогноз погоды
- **Geocoding API** - получение координат по названию города

### 4. Обработка ошибок
- Централизованная обработка через WeatherResult<T>
- Типизированные ошибки (timeout, no internet, server error и т.д.)
- Локализованные сообщения об ошибках

### 5. Локализация
- Поддержка русского языка
- Генерация из .arb файлов
- Форматирование дат на русском

## Установка и запуск

1. Установите зависимости:
```bash
flutter pub get
```

2. Сгенерируйте код для JSON сериализации:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Сгенерируйте файлы локализации:
```bash
flutter gen-strings
```

4. Запустите приложение:
```bash
flutter run
```

## API Key

API ключ OpenWeatherMap уже встроен в код (`eb404837e936b57aae44c7b14cb5a83b`).

Для использования собственного ключа измените константу `_apiKey` в файле `lib/network/weather/weather_api.dart`.

## Правила разработки

### Part-файлы
- Имя: `<имя_экрана>.<описание>.part.dart`
- В part-файле: `part of '<имя_экрана>.dart';`
- В основном файле: `part '<имя>.part.dart';`
- Никаких Observer внутри part-файлов
- Никаких навигаций внутри part-файлов
- Только Visibility вместо if

### Контроллеры
- Простые getters вверху
- Публичные методы
- Приватные методы внизу
- Observable поля для реактивного состояния
- Логика в приватных методах, не в геттерах

### Обработка ошибок
- try/catch только в API-слое
- Сначала success-path, потом ошибка
- Использовать WeatherResult<T>
- Не угадывать тип ошибки

### Форматирование
- Запятые везде где нужно
- Нулевые отступы внутри методов
- Один отступ между методами
- flutter format перед коммитом

## Цветовая схема

- Primary: `#1E88E5` (синий небесный)
- PrimaryLight: `#64B5F6` (светло-голубой)
- PrimaryDark: `#1565C0` (темно-синий)
- OnPrimary: `#FFFFFF` (белый)
- Error: `#F44336` (красный)
