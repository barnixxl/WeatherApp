import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../../main.dart';
import '../../models/api_forecast.dart';
import '../../models/hour_weather.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import '../../utils/int_extensions.dart';
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

  Future<void> initializeDependencies() async {
    _network = _getIt<WeatherNetwork>();
  }

  static WeatherApi getInstance() {
    return _getIt<WeatherApi>();
  }

  Future<WeatherResult<ApiForecast>> fetchForecast(
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

  WeatherResult<ApiForecast> _processNetworkResult(
    WeatherResult<Map<String, dynamic>> result,
  ) {
    if (result.isSuccess) {
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

  WeatherResult<ApiForecast> _parseForecastData(
    Map<String, dynamic> data,
  ) {
    try {
      final response = WeatherResponseFromNetwork.fromJson(
        data,
      );
      final list = response.list;
      if (list != null && list.isNotEmpty) {
        if (list.every((
          item,
        ) =>
            item.dt != null)) {
          return WeatherResult.success(
            _buildApiForecast(
              response,
            ),
          );
        }
        return WeatherResult.failure(
          WeatherError.invalidData(),
        );
      }
      return WeatherResult.failure(
        WeatherError.noData(),
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.parsing(),
      );
    }
  }

  ApiForecast _buildApiForecast(
    WeatherResponseFromNetwork response,
  ) {
    return ApiForecast(
      weatherData:
          (response.list ?? []).map((e) => _buildHourWeather(e)).toList(),
      cityName: response.city?.name ?? strings.common_unknow_city_name,
      latitude: response.city?.coord?.lat ?? 0.0,
      longitude: response.city?.coord?.lon ?? 0.0,
    );
  }

  HourWeather _buildHourWeather(
    WeatherItemFromNetwork item,
  ) {
    return HourWeather(
      dateTime: item.dt?.toDateTimeFromUnixSeconds(),
      temperature: item.main?.temp ?? 0.0,
      tempMin: item.main?.tempMin ?? 0.0,
      tempMax: item.main?.tempMax ?? 0.0,
      weatherState: WeatherStateAssets.fromCode(
        item.weather?.firstOrNull?.icon ?? '',
      ),
    );
  }
}
