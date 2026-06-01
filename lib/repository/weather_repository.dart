import 'package:get_it/get_it.dart';

import '../models/day_weather.dart';
import '../models/weather_data.dart';
import '../models/weather_error.dart';
import '../models/weather_result.dart';
import '../network/weather/weather_api.dart';
import '../network/weather/resp/weather_item_from_network.dart';
import '../network/geocoding/geocoding_api.dart';
import 'base_repository.dart';

class WeatherRepository extends BaseRepository {
  final WeatherApi _weatherApi;
  final GeocodingApi _geocodingApi;

  WeatherRepository({
    required WeatherApi weatherApi,
    required GeocodingApi geocodingApi,
  })  : _weatherApi = weatherApi,
        _geocodingApi = geocodingApi;

  @override
  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherRepository>(
      this,
    );
  }

  Future<WeatherResult<List<DayWeather>>> fetchForecast(
    double lat,
    double lon,
  ) async {
    final result = await _weatherApi.fetchForecast(
      lat,
      lon,
    );
    if (result.isSuccess) {
      final response = result.data;
      if (response == null) {
        return WeatherResult.failure(
          WeatherError.noData(),
        );
      }
      final weatherList = (response.list ?? [])
          .map(
            _toWeatherData,
          )
          .toList();
      final grouped = _groupByDay(
        weatherList,
      );
      final filtered = _filterHourlyData(
        grouped,
      );
      return WeatherResult.success(
        filtered,
      );
    }
    return WeatherResult.failure(
      result.error,
    );
  }

  Future<WeatherResult<Map<String, double>>> getCoordinates(
    String cityName,
  ) async {
    return await _geocodingApi.getCoordinates(
      cityName,
    );
  }

  Future<WeatherResult<String>> getCityName(
    double lat,
    double lon,
  ) async {
    return await _geocodingApi.getCityName(
      lat,
      lon,
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
      (entry) {
        final date = DateTime.parse(
          entry.key,
        );
        return DayWeather(
          date: date,
          hourlyData: entry.value,
        );
      },
    ).toList();
  }

  WeatherData _toWeatherData(
    WeatherItemFromNetwork model,
  ) {
    return WeatherData(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (model.dt ?? 0) * 1000,
      ),
      temperature: model.main?.temp ?? 0.0,
      weatherMain: model.weather?.firstOrNull?.main ?? '',
      weatherDescription: model.weather?.firstOrNull?.description ?? '',
      weatherIcon: model.weather?.firstOrNull?.icon ?? '',
      windSpeed: model.wind?.speed ?? 0.0,
      humidity: model.main?.humidity ?? 0,
    );
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
        return DayWeather(
          date: dayWeather.date,
          hourlyData: filtered,
        );
      },
    ).toList();
  }
}
