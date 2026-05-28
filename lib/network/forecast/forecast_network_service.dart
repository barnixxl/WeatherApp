import 'package:get_it/get_it.dart';

import '../network_service.dart';

class ForecastNetworkService extends NetworkService {
  ForecastNetworkService()
      : super(
          baseUrl: 'https://api.openweathermap.org/data/2.5/',
        );

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<ForecastNetworkService>(
      this,
    );
  }
}
