import 'package:get_it/get_it.dart';

import '../models/day_weather.dart';
import '../models/forecast_result.dart';
import '../models/weather_data.dart';
import '../models/weather_forecast_data.dart';
import '../models/weather_error.dart';
import '../models/weather_result.dart';
import '../network/weather/weather_api.dart';
import 'base_repository.dart';

class WeatherRepository extends BaseRepository {
  static final GetIt _getIt = GetIt.instance;

  late final WeatherApi _weatherApi;

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
  }

  static WeatherRepository getInstance() {
    return _getIt<WeatherRepository>();
  }

  Future<WeatherResult<ForecastResult>> fetchForecast(
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
    return _groupAndFilterForecast(
      result.data,
    );
  }

  WeatherResult<ForecastResult> _groupAndFilterForecast(
    WeatherForecastData? data,
  ) {
    if (data == null) {
      return WeatherResult.failure(
        WeatherError.noData(),
      );
    }
    final grouped = _groupByDay(
      data.weatherData,
    );
    final dayWeather = grouped.entries
        .map((e) => _createDayWeather(
              e.key,
              e.value,
            ))
        .toList();
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
    return DayWeather(
      date: date,
      hourlyData: hourlyData,
      dayMinTemp: temps.isEmpty ? 0.0 : temps.reduce((a, b) => a < b ? a : b),
      dayMaxTemp: temps.isEmpty ? 0.0 : temps.reduce((a, b) => a > b ? a : b),
    );
  }

  List<DayWeather> _filterEvenHours(
    List<DayWeather> dayWeatherList,
  ) {
    return dayWeatherList.map(
      (dayWeather) {
        final filtered = dayWeather.hourlyData.where(
          (weather) {
            final hour = weather.dateTime.hour;
            return hour % 2 == 0;
          },
        ).toList();
        return DayWeather(
          date: dayWeather.date,
          hourlyData: filtered,
          dayMinTemp: dayWeather.dayMinTemp,
          dayMaxTemp: dayWeather.dayMaxTemp,
        );
      },
    ).toList();
  }
}
