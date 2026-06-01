import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'network/geocoding/geocoding_api.dart';
import 'network/geocoding/geocoding_network_service.dart';
import 'network/weather/weather_api.dart';
import 'network/weather/weather_network_service.dart';
import 'repository/weather_repository.dart';
import 'resources/colors/app_colors.dart';
import 'resources/strings/app_localizations.dart';
import 'ui/home/home_controller.dart';
import 'ui/home/home_screen.dart';
import 'utils/location_service.dart';

late final AppLocalizations strings;

Future<void> initializeLocale() async {
  await initializeDateFormatting(
    'ru',
    null,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initializeLocale();
  strings = lookupAppLocalizations(
    const Locale(
      'ru',
    ),
  );
  final getIt = GetIt.instance;

  final weatherNetwork = WeatherNetworkService();
  weatherNetwork.register(
    getIt,
  );
  await weatherNetwork.initializeDependencies();

  final geocodingNetwork = GeocodingNetworkService();
  geocodingNetwork.register(
    getIt,
  );
  await geocodingNetwork.initializeDependencies();

  final weatherApi = WeatherApi(
    network: weatherNetwork,
  );
  weatherApi.register(
    getIt,
  );

  final geocodingApi = GeocodingApi(
    network: geocodingNetwork,
  );
  geocodingApi.register(
    getIt,
  );

  final locationService = LocationService();
  locationService.register(
    getIt,
  );
  await locationService.initializeDependencies();

  final repository = WeatherRepository(
    weatherApi: weatherApi,
    geocodingApi: geocodingApi,
  );
  repository.register(
    getIt,
  );

  final controller = HomeController(
    repository: repository,
    locationService: locationService,
  );

  runApp(
    MyApp(
      homeController: controller,
    ),
  );
}

class MyApp extends StatelessWidget {
  final HomeController homeController;

  MyApp({
    super.key,
    required this.homeController,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      locale: const Locale(
        'ru',
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      home: HomeScreen(
        homeController: homeController,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
