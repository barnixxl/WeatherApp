import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../forecast_network.dart';
import 'resp/forecast_response_from_network.dart';

class ForecastApi {
  static final GetIt _getIt = GetIt.instance;

  late final WeatherNetwork _network;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<ForecastApi>(
      this,
    );
  }

  Future<void> initializeDependencies() async {
    _network = _getIt<WeatherNetwork>();
  }

  Future<WeatherResult<ForecastResponseFromNetwork>> fetchForecast(
    double lat,
    double lon,
  ) async {
    const url = 'forecast';
    final queryParams = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': AppConfig.apiKey,
      'units': 'metric',
      'lang': 'ru',
    };
    try {
      final result = await _network.get(
        url,
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
