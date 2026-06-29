import 'dart:math';

import 'package:get_it/get_it.dart';

import '../models/day_weather.dart';
import '../models/forecast_result.dart';
import '../models/weather_data.dart';
import '../models/weather_error.dart';
import '../models/weather_forecast_data.dart';
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
        (
          a,
          b,
        ) =>
            a.date.compareTo(
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
