import 'package:get_it/get_it.dart';

import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import 'weather_network_service.dart';
import 'resp/weather_response_from_network.dart';

class WeatherApi {
  final WeatherNetworkService _network;

  WeatherApi({
    required WeatherNetworkService network,
  }) : _network = network;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherApi>(
      this,
    );
  }

  Future<WeatherResult<WeatherResponseFromNetwork>> fetchForecast(
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
      if (result.error == null) {
        final data = result.data;
        if (data is Map<String, dynamic>) {
          final response = WeatherResponseFromNetwork.fromJson(
            data,
          );
          return WeatherResult.success(
            response,
          );
        }
        return WeatherResult.failure(
          WeatherError.parsing(),
        );
      }
      return WeatherResult.failure(
        result.error,
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.fromException(
          e,
        ),
      );
    }
  }
}
