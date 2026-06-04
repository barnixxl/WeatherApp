import 'package:get_it/get_it.dart';

import '../../models/coordinates.dart';
import '../../models/weather_result.dart';
import 'geocoding_network_service.dart';
import 'resp/geocoding_response_from_network.dart';

class GeocodingApi {
  static final GetIt _getIt = GetIt.instance;

  late final GeocodingNetworkService _network;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<GeocodingApi>(
      this,
    );
  }

  Future<void> initializeDependencies() async {
    _network = _getIt<GeocodingNetworkService>();
  }

  Future<WeatherResult<Coordinates>> getCoordinates(
    String cityName,
  ) async {
    final result = await _network.get(
      'direct',
      queryParameters: {
        'q': cityName,
        'limit': '1',
      },
    );
    if (result.isSuccess) {
      final data = result.data as List<dynamic>;
      final item = data.first as Map<String, dynamic>;
      final response = GeocodingResponseFromNetwork.fromJson(item);
      return WeatherResult.success(
        Coordinates(
          lat: response.lat ?? 0.0,
          lon: response.lon ?? 0.0,
        ),
      );
    }
    return WeatherResult.failure(
      result.error,
    );
  }

  Future<WeatherResult<String>> getCityName(
    double lat,
    double lon,
  ) async {
    final result = await _network.get(
      'reverse',
      queryParameters: {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'limit': '1',
      },
    );
    if (result.isSuccess) {
      final data = result.data as List<dynamic>;
      final item = data.first as Map<String, dynamic>;
      final response = GeocodingResponseFromNetwork.fromJson(item);
      final cityName =
          response.localNames?['ru'] ?? response.name ?? 'Unknown';
      return WeatherResult.success(
        cityName,
      );
    }
    return WeatherResult.failure(
      result.error,
    );
  }
}
