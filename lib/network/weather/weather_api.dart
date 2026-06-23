import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../main.dart';
import '../../models/weather_data.dart';
import '../../models/weather_error.dart';
import '../../models/weather_forecast_data.dart';
import '../../models/weather_result.dart';
import '../../utils/int_extensions.dart';
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
      if (result.isSuccess) {
        return _parseForecastResponse(
          result.data,
        );
      }
      return WeatherResult.failure(
        result.error,
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.fromException(e),
      );
    }
  }

  WeatherResult<WeatherForecastData> _parseForecastResponse(
    Map<String, dynamic>? data,
  ) {
    if (data != null) {
      final response = WeatherResponseFromNetwork.fromJson(
        data,
      );
      return WeatherResult.success(
        WeatherForecastData(
          weatherData: (response.list ?? [])
              .map(
                (e) => WeatherData(
                  dateTime: e.dt.toDateTimeFromUnixSeconds() ?? DateTime.now(),
                  temperature: e.main?.temp ?? 0.0,
                  tempMin: e.main?.tempMin ?? 0.0,
                  tempMax: e.main?.tempMax ?? 0.0,
                  weatherMain: e.weather?.firstOrNull?.main ?? '',
                  weatherDescription: e.weather?.firstOrNull?.description ?? '',
                  weatherIcon: e.weather?.firstOrNull?.icon ?? '',
                  windSpeed: e.wind?.speed ?? 0.0,
                ),
              )
              .toList(),
          cityName: response.city?.name ?? strings.common_unknow_city_name,
          latitude: response.city?.coord?.lat ?? 0.0,
          longitude: response.city?.coord?.lon ?? 0.0,
        ),
      );
    }
    return WeatherResult.failure(
      WeatherError.noData(),
    );
  }
}
