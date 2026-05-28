import 'package:get_it/get_it.dart';

import '../network_service.dart';

class GeocodingNetworkService extends NetworkService {
  GeocodingNetworkService()
      : super(
          baseUrl: 'https://api.openweathermap.org/geo/1.0/',
        );

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<GeocodingNetworkService>(
      this,
    );
  }
}
