import 'package:get_it/get_it.dart';

import '../../models/weather_data.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../weather_network.dart';
import 'resp/items/weather_items_from_network.dart';
import 'resp/weather_response_from_network.dart';

class WeatherApi {
  static final GetIt _getIt = GetIt.instance;

  late final WeatherNetwork _network;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherApi>(
      this,
    );
  }

  WeatherData _mapToWeatherData(
    WeatherItemFromNetwork item,
  ) {
    final dt = item.dt;
    return WeatherData(
      dateTime: dt != null
          ? DateTime.fromMillisecondsSinceEpoch(
              dt * 1000,
              isUtc: true,
            ).toLocal()
          : DateTime.now(),
      temperature: item.main?.temp ?? 0.0,
      tempMin: item.main?.tempMin ?? 0.0,
      tempMax: item.main?.tempMax ?? 0.0,
      weatherMain: item.weather?.firstOrNull?.main ?? '',
      weatherDescription: item.weather?.firstOrNull?.description ?? '',
      weatherIcon: item.weather?.firstOrNull?.icon ?? '',
      windSpeed: item.wind?.speed ?? 0.0,
      humidity: item.main?.humidity ?? 0,
    );
  }

  Future<void> initializeDependencies() async {
    _network = _getIt<WeatherNetwork>();
  }

  Future<WeatherResult<(List<WeatherData>, String)>> fetchForecast(
    double lat,
    double lon,
  ) async {
    const path = 'forecast';
    final queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'units': 'metric',
      'lang': 'ru',
    };
    try {
      final result = await _network.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParams,
      );
      if (result.isSuccess) {
        final data = result.data;
        if (data == null) {
          return WeatherResult.failure(
            WeatherError.noData(),
          );
        }
        final response = WeatherResponseFromNetwork.fromJson(
          data,
        );
        final cityName = response.city?.name ?? 'Unknown';
        final weatherList = (response.list ?? [])
            .map(
              _mapToWeatherData,
            )
            .toList();
        return WeatherResult.success(
          (
            weatherList,
            cityName,
          ),
        );
      }
      return WeatherResult.failure(
        result.error ?? WeatherError.unknown(),
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.fromException(e),
      );
    }
  }
}
