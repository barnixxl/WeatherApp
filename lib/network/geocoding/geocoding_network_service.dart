import 'package:get_it/get_it.dart';

import '../../config/app_config.dart';
import '../network_service.dart';

class GeocodingNetworkService extends NetworkService {
  GeocodingNetworkService()
      : super(
          baseUrl: 'https://api.openweathermap.org/geo/1.0/',
          defaultQueryParams: {
            'appid': AppConfig.apiKey,
          },
        );

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<GeocodingNetworkService>(
      this,
    );
  }
}
