import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

class LocationService {
  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<LocationService>(
      this,
    );
  }

  Future<void> initializeDependencies() async {}

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }
}
