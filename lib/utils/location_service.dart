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

  // Future<void> initializeDependencies() async {}  - для будущих полей если понадобиться

  static LocationService getInstance() {
    return _getIt<LocationService>();
  }

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
