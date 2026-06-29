import 'dart:math';

import 'package:get_it/get_it.dart';

import '../models/day_weather.dart';
import '../models/forecast_result.dart';
import '../models/weather_data.dart';
import '../models/weather_error.dart';
import '../models/weather_forecast_data.dart';
import '../models/weather_result.dart';
import '../network/weather/weather_api.dart';
import '../resources/images/weather_state_images/weather_state_images.dart';
import '../utils/location_service.dart';
import 'base_repository.dart';

class WeatherRepository extends BaseRepository {
  static final GetIt _getIt = GetIt.instance;

  late final WeatherApi _weatherApi;
  late final LocationService _locationService;

  @override
  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherRepository>(
      this,
    );
  }

  @override
  Future<void> initializeDependencies() async {
    _weatherApi = _getIt<WeatherApi>();
    _locationService = _getIt<LocationService>();
  }

  static WeatherRepository getInstance() {
    return _getIt<WeatherRepository>();
  }

  Future<WeatherResult<ForecastResult>> fetchForecast() async {
    final serviceEnabled = await _locationService.isLocationServiceEnabled();
    if (serviceEnabled) {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        return _fetchAndGroup(
          position.latitude,
          position.longitude,
        );
      }
      return WeatherResult.failure(
        WeatherError.noGeo(),
      );
    }
    return WeatherResult.failure(
      WeatherError.gpsDisabled(),
    );
  }

  Future<WeatherResult<ForecastResult>> _fetchAndGroup(
    double lat,
    double lon,
  ) async {
    final result = await _weatherApi.fetchForecast(
      lat,
      lon,
    );
    if (result.isError) {
      return WeatherResult.failure(
        result.error,
      );
    }
    final data = result.data;
    if (data != null) {
      return _groupAndFilterForecast(
        data,
      );
    }
    return WeatherResult.failure(
      WeatherError.loadFailed(),
    );
  }

  WeatherResult<ForecastResult> _groupAndFilterForecast(
    WeatherForecastData data,
  ) {
    final grouped = _groupByDay(
      data.weatherData,
    );
    final dayWeather = grouped.entries
        .map((e) => _createDayWeather(
              e.key,
              e.value,
            ))
        .toList()
      ..sort(
        (a, b) => a.date.compareTo(
          b.date,
        ),
      );
    final resultWeather = _filterEvenHours(
      dayWeather,
    );
    return WeatherResult.success(
      ForecastResult(
        dayWeather: resultWeather,
        cityName: data.cityName,
        latitude: data.latitude,
        longitude: data.longitude,
      ),
    );
  }

  Map<DateTime, List<WeatherData>> _groupByDay(
    List<WeatherData> weatherList,
  ) {
    final Map<DateTime, List<WeatherData>> grouped = {};
    for (final weather in weatherList) {
      final date = DateTime(
        weather.dateTime.year,
        weather.dateTime.month,
        weather.dateTime.day,
      );
      grouped
          .putIfAbsent(
            date,
            () => [],
          )
          .add(
            weather,
          );
    }
    return grouped;
  }

  DayWeather _createDayWeather(
    DateTime date,
    List<WeatherData> hourlyData,
  ) {
    final temps = hourlyData.map(
      (e) => e.temperature,
    );
    if (temps.isNotEmpty) {
      return DayWeather(
        date: date,
        hourlyData: hourlyData,
        dayMinTemp: temps.reduce(
          min,
        ),
        dayMaxTemp: temps.reduce(
          max,
        ),
      );
    }
    return DayWeather(
      date: date,
      hourlyData: hourlyData,
      dayMinTemp: 0.0,
      dayMaxTemp: 0.0,
    );
  }

  List<DayWeather> _filterEvenHours(
    List<DayWeather> dayWeatherList,
  ) {
    return dayWeatherList.map((
      dayWeather,
    ) {
      final filtered = dayWeather.hourlyData
          .where((weather) => weather.dateTime.hour.isEven)
          .toList();
      return DayWeather(
        date: dayWeather.date,
        hourlyData: filtered,
        dayMinTemp: dayWeather.dayMinTemp,
        dayMaxTemp: dayWeather.dayMaxTemp,
      );
    }).toList();
  }
}

enum WeatherStateAssets {
  sun,
  moon,
  sunBehindCloud,
  moonBehindCloud,
  greyClouds,
  greyCloudsNight,
  darkClouds,
  darkCloudsNight,
  rain,
  rainNight,
  sunRain,
  sunRainNight,
  thunderstorm,
  thunderstormNight,
  snow,
  snowNight,
  fog,
  fogNight;

  String get imagePath {
    switch (this) {
      case WeatherStateAssets.sun:
        return WeatherStateImages.sun;
      case WeatherStateAssets.moon:
        return WeatherStateImages.moon;
      case WeatherStateAssets.sunBehindCloud:
        return WeatherStateImages.sunBehindCloud;
      case WeatherStateAssets.moonBehindCloud:
        return WeatherStateImages.moonBehindCloud;
      case WeatherStateAssets.greyClouds:
        return WeatherStateImages.greyClouds;
      case WeatherStateAssets.greyCloudsNight:
        return WeatherStateImages.greyCloudsNight;
      case WeatherStateAssets.darkClouds:
        return WeatherStateImages.darkClouds;
      case WeatherStateAssets.darkCloudsNight:
        return WeatherStateImages.darkCloudsNight;
      case WeatherStateAssets.rain:
        return WeatherStateImages.rain;
      case WeatherStateAssets.rainNight:
        return WeatherStateImages.rainNight;
      case WeatherStateAssets.sunRain:
        return WeatherStateImages.sunRain;
      case WeatherStateAssets.sunRainNight:
        return WeatherStateImages.sunRainNight;
      case WeatherStateAssets.thunderstorm:
        return WeatherStateImages.thunderstorm;
      case WeatherStateAssets.thunderstormNight:
        return WeatherStateImages.thunderstormNight;
      case WeatherStateAssets.snow:
        return WeatherStateImages.snow;
      case WeatherStateAssets.snowNight:
        return WeatherStateImages.snowNight;
      case WeatherStateAssets.fog:
        return WeatherStateImages.fog;
      case WeatherStateAssets.fogNight:
        return WeatherStateImages.fogNight;
    }
  }

  static WeatherStateAssets fromCode(
    String code,
  ) {
    switch (code) {
      case '01d':
        return WeatherStateAssets.sun;
      case '01n':
        return WeatherStateAssets.moon;
      case '02d':
        return WeatherStateAssets.sunBehindCloud;
      case '02n':
        return WeatherStateAssets.moonBehindCloud;
      case '03d':
        return WeatherStateAssets.greyClouds;
      case '03n':
        return WeatherStateAssets.greyCloudsNight;
      case '04d':
        return WeatherStateAssets.darkClouds;
      case '04n':
        return WeatherStateAssets.darkCloudsNight;
      case '09d':
        return WeatherStateAssets.rain;
      case '09n':
        return WeatherStateAssets.rainNight;
      case '10d':
        return WeatherStateAssets.sunRain;
      case '10n':
        return WeatherStateAssets.sunRainNight;
      case '11d':
        return WeatherStateAssets.thunderstorm;
      case '11n':
        return WeatherStateAssets.thunderstormNight;
      case '13d':
        return WeatherStateAssets.snow;
      case '13n':
        return WeatherStateAssets.snowNight;
      case '50d':
        return WeatherStateAssets.fog;
      case '50n':
        return WeatherStateAssets.fogNight;
      default:
        return WeatherStateAssets.sun;
    }
  }
}
