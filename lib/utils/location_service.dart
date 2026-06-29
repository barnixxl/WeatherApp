import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

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

  Future<void> initializeDependencies() async {
  }

  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position?> getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(
          seconds: 10,
        ),
      ),
    );
  }
}
