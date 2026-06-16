import 'package:get_it/get_it.dart';

import '../../models/weather_data.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../weather_network.dart';
import 'resp/weather_response_from_network.dart';

class WeatherApi {
  static final GetIt _getIt = GetIt.instance;

  late final WeatherNetworkService _network;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherApi>(
      this,
    );
  }

  Future<void> initializeDependencies() async {
    _network = _getIt<WeatherNetworkService>();
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
      final result = await _network.get(
        path,
        queryParameters: queryParams,
      );
      if (result.isSuccess) {
        final data = result.data as Map<String, dynamic>;
        final response = WeatherResponseFromNetwork.fromJson(
          data,
        );
        final cityName = response.city?.name ?? 'Unknown';
        final weatherList = (response.list ?? [])
            .map(
              (e) => e.toDomain(),
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
        result.error,
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.parsing(),
      );
    }
  }
}
