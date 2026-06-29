import 'dart:math';

import 'package:get_it/get_it.dart';

import '../models/day_weather.dart';
import '../models/forecast_data.dart';
import '../models/hour_weather.dart';
import '../models/weather_error.dart';
import '../models/api_forecast.dart';
import '../models/weather_result.dart';
import '../network/weather/weather_api.dart';
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

  Future<WeatherResult<ForecastData>> fetchForecast() async {
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

  Future<WeatherResult<ForecastData>> _fetchAndGroup(
    double lat,
    double lon,
  ) async {
    final result = await _weatherApi.fetchForecast(
      lat,
      lon,
    );
    if (result.isSuccess) {
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
    return WeatherResult.failure(
      result.error,
    );
  }

  WeatherResult<ForecastData> _groupAndFilterForecast(
    ApiForecast data,
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
        (
          a,
          b,
        ) =>
            a.date.compareTo(
          b.date,
        ),
      );
    return WeatherResult.success(
      ForecastData(
        dayWeather: dayWeather,
        cityName: data.cityName,
        latitude: data.latitude,
        longitude: data.longitude,
      ),
    );
  }

  Map<DateTime, List<HourWeather>> _groupByDay(
    List<HourWeather> weatherList,
  ) {
    final Map<DateTime, List<HourWeather>> grouped = {};
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
    List<HourWeather> hourlyData,
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
}
