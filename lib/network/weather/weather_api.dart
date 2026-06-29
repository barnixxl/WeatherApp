import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../main.dart';
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
    final apiKey = AppConfig.apiKey;
    if (apiKey != null) {
      final result = await _network.get<Map<String, dynamic>>(
        'forecast',
        queryParameters: _buildQueryParams(
          apiKey,
          lat,
          lon,
        ),
      );
      return _processNetworkResult(
        result,
      );
    }
    return WeatherResult.failure(
      WeatherError.configError(
        strings.error_config,
      ),
    );
  }

  Map<String, String> _buildQueryParams(
    String apiKey,
    double lat,
    double lon,
  ) {
    return {
      'appid': apiKey,
      'lat': lat.toString(),
      'lon': lon.toString(),
      'units': 'metric',
      'lang': 'ru',
    };
  }

  WeatherResult<WeatherForecastData> _processNetworkResult(
    WeatherResult<Map<String, dynamic>> result,
  ) {
    if (result.error == null) {
      final data = result.data;
      if (data != null) {
        return _parseForecastData(
          data,
        );
      }
      return WeatherResult.failure(
        WeatherError.loadFailed(),
      );
    }
    return WeatherResult.failure(
      result.error,
    );
  }

  WeatherResult<WeatherForecastData> _parseForecastData(
    Map<String, dynamic> data,
  ) {
    try {
      final response = WeatherResponseFromNetwork.fromJson(
        data,
      );
      final allItemsValid =
          (response.list ?? []).every((item) => item.dt != null);
      if (allItemsValid) {
        return WeatherResult.success(
          WeatherForecastData.fromNetworkModel(
            response,
          ),
        );
      }
      return WeatherResult.failure(
        WeatherError.invalidData(),
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.parsing(),
      );
    }
  }
}
