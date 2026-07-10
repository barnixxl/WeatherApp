import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

import '../models/weather_error.dart';
import '../models/weather_result.dart';

class LocationService {
  static final GetIt _getIt = GetIt.instance;

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<LocationService>(
      this,
    );
  }

  static LocationService getInstance() {
    return _getIt<LocationService>();
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<WeatherResult<Position>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return WeatherResult.failure(
          WeatherError.noGeo(),
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return WeatherResult.failure(
        WeatherError.noGeo(),
      );
    }
    try {
      return WeatherResult.success(
        await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(
              seconds: 10,
            ),
          ),
        ),
      );
    } on TimeoutException {
      return WeatherResult.failure(
        WeatherError.locationTimeout(),
      );
    } catch (e) {
      return WeatherResult.failure(
        WeatherError.fromException(e),
      );
    }
  }
}
