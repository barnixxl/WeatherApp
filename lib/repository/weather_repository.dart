import 'package:get_it/get_it.dart';

import '../models/day_forecast.dart';
import '../models/weather_data.dart';
import '../models/weather_error.dart';
import '../models/weather_result.dart';
import '../network/forecast/forecast_api.dart';
import '../network/geocoding/geocoding_api.dart';
import 'base_repository.dart';

class WeatherRepository extends BaseRepository {
  static final GetIt _getIt = GetIt.instance;

  late final ForecastApi _forecastApi;
  late final GeocodingApi _geocodingApi;

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
    _forecastApi = _getIt<ForecastApi>();
    _geocodingApi = _getIt<GeocodingApi>();
  }

  static WeatherRepository getInstance() {
    return _getIt<WeatherRepository>();
  }

  Future<WeatherResult<List<DayForecast>>> fetchForecast(
    double lat,
    double lon,
  ) async {
    final result = await _forecastApi.fetchForecast(
      lat,
      lon,
    );
    if (result.isError) {
      return WeatherResult.failure(
        result.error,
      );
    }
    final response = result.data;
    if (response == null) {
      return WeatherResult.failure(
        WeatherError.noData(),
      );
    }
    final weatherList = (response.list ?? [])
        .map(
          (e) => WeatherData.fromNetworkModel(
            e,
          ),
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

  List<DayForecast> _groupByDay(
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
        return DayForecast(
          date: date,
          hourlyData: entry.value,
        );
      },
    ).toList();
  }

  String _getDateKey(
    DateTime dateTime,
  ) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  List<DayForecast> _filterHourlyData(
    List<DayForecast> forecasts,
  ) {
    return forecasts.map(
      (dayForecast) {
        final filtered = dayForecast.hourlyData.where(
          (weather) {
            final hour = weather.dateTime.hour;
            return hour % 2 == 0;
          },
        ).toList();
        return DayForecast(
          date: dayForecast.date,
          hourlyData: filtered,
        );
      },
    ).toList();
  }
}
