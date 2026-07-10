import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../models/forecast_response.dart';
import '../../models/weather_error.dart';
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

  static WeatherApi getInstance() {
    return _getIt<WeatherApi>();
  }

  Future<WeatherResult<ForecastResponse>> fetchForecast(
    double lat,
    double lon,
  ) async {
    final apiKey = AppConfig.apiKey;
    if (apiKey != null && apiKey.isNotEmpty) {
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
        lat,
        lon,
      );
    }
    return WeatherResult.failure(
      WeatherError.configError(),
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
      'units': AppConfig.units,
      'lang': AppConfig.language,
    };
  }

  WeatherResult<ForecastResponse> _processNetworkResult(
    WeatherResult<Map<String, dynamic>> result,
    double lat,
    double lon,
  ) {
    if (result.isSuccess) {
      final data = result.data;
      if (data != null) {
        return _parseForecastData(
          data,
          lat,
          lon,
        );
      }
      return WeatherResult.failure(
        WeatherError.loadFailed(),
      );
    }
    return WeatherResult.failure(
      result.error ?? WeatherError.unknown(),
    );
  }

  WeatherResult<ForecastResponse> _parseForecastData(
    Map<String, dynamic> data,
    double lat,
    double lon,
  ) {
    try {
      final response = WeatherResponseFromNetwork.fromJson(
        data,
      );
      final list = response.list;
      if (list != null && list.isNotEmpty) {
        return WeatherResult.success(
          ForecastResponse.fromNetworkModel(
            response,
            lat,
            lon,
          ),
        );
      }
      return WeatherResult.failure(
        WeatherError.noData(),
      );
    } catch (e) {
      debugPrint(e.toString());
      return WeatherResult.failure(
        WeatherError.fromException(e),
      );
    }
  }
}
