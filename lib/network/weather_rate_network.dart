import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import 'network_service.dart';

class WeatherRateNetwork extends NetworkService {
  WeatherRateNetwork()
      : super(
          baseUrl: 'https://api.openweathermap.org/data/2.5/',
          defaultQueryParams: {
            'appid': AppConfig.apiKey,
          },
        );

  void register(
    GetIt getIt,
  ) {
    getIt.registerSingleton<WeatherRateNetwork>(
      this,
    );
  }
}
