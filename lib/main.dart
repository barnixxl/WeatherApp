import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'network/weather/weather_api.dart';
import 'network/weather/weather_network_service.dart';
import 'network/geocoding/geocoding_api.dart';
import 'network/geocoding/geocoding_network_service.dart';
import 'repository/weather_repository.dart';
import 'resources/colors/app_colors.dart';
import 'resources/strings/app_localizations.dart';
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

  final weatherApi = WeatherApi();
  weatherApi.register(
    getIt,
  );
  await weatherApi.initializeDependencies();

  final geocodingApi = GeocodingApi();
  geocodingApi.register(
    getIt,
  );
  await geocodingApi.initializeDependencies();

  final locationService = LocationService();
  locationService.register(
    getIt,
  );
  await locationService.initializeDependencies();

  final repository = WeatherRepository();
  repository.register(
    getIt,
  );
  await repository.initializeDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      locale: const Locale(
        'ru',
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
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
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
