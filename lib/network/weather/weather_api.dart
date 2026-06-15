import 'package:get_it/get_it.dart';

import '../../models/weather_data.dart';
import '../../models/weather_error.dart';
import '../../models/weather_result.dart';
import 'weather_network_service.dart';
import 'resp/weather_item_from_network.dart';
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

  WeatherData _mapToWeatherData(
    WeatherItemFromNetwork model,
  ) {
    return WeatherData(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (model.dt ?? 0) * 1000,
      ),
      temperature: model.main?.temp ?? 0.0,
      weatherMain: model.weather?.firstOrNull?.main ?? '',
      weatherDescription: model.weather?.firstOrNull?.description ?? '',
      weatherIcon: model.weather?.firstOrNull?.icon ?? '',
      windSpeed: model.wind?.speed ?? 0.0,
      humidity: model.main?.humidity ?? 0,
    );
  }

  Future<WeatherResult<List<WeatherData>>> fetchForecast(
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
    final result = await _network.get(
      path,
      queryParameters: queryParams,
    );
    if (result.isSuccess) {
      try {
        final data = result.data as Map<String, dynamic>;
        final response = WeatherResponseFromNetwork.fromJson(
          data,
        );
        final weatherList = (response.list ?? [])
            .map(
              _mapToWeatherData,
            )
            .toList();
        return WeatherResult.success(
          weatherList,
        );
      } catch (e) {
        return WeatherResult.failure(
          WeatherError.parsing(),
        );
      }
    }
    return WeatherResult.failure(
      result.error,
    );
  }
}
