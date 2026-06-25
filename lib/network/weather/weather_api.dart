import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../models/weather_error.dart';
import '../../models/weather_forecast_data.dart';
import '../../models/weather_result.dart';
import '../weather_network.dart';
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

  Future<void> initializeDependencies() async {
    _network = _getIt<WeatherNetwork>();
  }

  Future<WeatherResult<WeatherForecastData>> fetchForecast(
    double lat,
    double lon,
  ) async {
    const path = 'forecast';
    final queryParams = {
      'appid': AppConfig.apiKey,
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
      if (result.error == null) {
        final data = result.data;
        if (data != null) {
          final response = WeatherResponseFromNetwork.fromJson(
            data,
          );
          return WeatherResult.success(
            WeatherForecastData.fromNetworkModel(
              response,
            ),
          );
        }
      }
      return WeatherResult.failure(
        result.error ?? WeatherError.loadFailed(),
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.fromException(e),
      );
    }
  }
}
