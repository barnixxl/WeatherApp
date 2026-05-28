import 'package:get_it/get_it.dart';

import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import 'forecast_network_service.dart';
import 'resp/forecast_response_from_network.dart';

class ForecastApi {
  static final GetIt _getIt = GetIt.instance;

  late final ForecastNetworkService _network;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<ForecastApi>(
      this,
    );
  }

  Future<void> initializeDependencies() async {
    _network = _getIt<ForecastNetworkService>();
  }

  Future<WeatherResult<ForecastResponseFromNetwork>> fetchForecast(
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
          final response = ForecastResponseFromNetwork.fromJson(
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
