import 'package:get_it/get_it.dart';

import '../models/day_weather.dart';
import '../models/weather_data.dart';
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

  Future<WeatherResult<(List<DayWeather>, String)>> fetchForecast(
    double lat,
    double lon,
  ) async {
    final result = await _weatherApi.fetchForecast(
      lat,
      lon,
    );
    if (result.isSuccess) {
      final (
        weatherData,
        cityName,
      ) = result.data!;
      final grouped = _groupByDay(
        weatherData,
      );
      final filtered = _filterHourlyData(
        grouped,
      );
      return WeatherResult.success(
        (
          filtered,
          cityName,
        ),
      );
    }
    return WeatherResult.failure(
      result.error,
    );
  }

  List<DayWeather> _groupByDay(
    List<WeatherData> weatherList,
  ) {
    final Map<String, List<WeatherData>> grouped = {};
    for (final weather in weatherList) {
      final dateKey = _getDateKey(
        weather.dateTime,
      );
      grouped
          .putIfAbsent(
            dateKey,
            () => [],
          )
          .add(
            weather,
          );
    }
    return grouped.entries.map(
      (
        entry,
      ) {
        final date = DateTime.parse(
          entry.key,
        );
        return DayWeather(
          date: date,
          hourlyData: entry.value,
          dayMinTemp: 0.0,
          dayMaxTemp: 0.0,
        );
      },
    ).toList();
  }

  String _getDateKey(
    DateTime dateTime,
  ) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  List<DayWeather> _filterHourlyData(
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
        final temps = filtered.map(
          (e) => e.temperature,
        );
        final dayMinTemp = temps.isEmpty
            ? 0.0
            : temps.reduce(
                (a, b) => a < b ? a : b,
              );
        final dayMaxTemp = temps.isEmpty
            ? 0.0
            : temps.reduce(
                (a, b) => a > b ? a : b,
              );
        return DayWeather(
          date: dayWeather.date,
          hourlyData: filtered,
          dayMinTemp: dayMinTemp,
          dayMaxTemp: dayMaxTemp,
        );
      },
    ).toList();
  }
}
