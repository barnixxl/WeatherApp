import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'network/weather/weather_api.dart';
import 'network/weather_network.dart';
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
  try {
    await dotenv.load();
  } catch (_) {}
  await initializeLocale();
  strings = lookupAppLocalizations(
    const Locale(
      'ru',
    ),
  );
  final getIt = GetIt.instance;

  final weatherNetwork = WeatherNetwork();
  weatherNetwork.register(
    getIt,
  );
  await weatherNetwork.initializeDependencies();

  final weatherApi = WeatherApi();
  weatherApi.register(
    getIt,
  );
  await weatherApi.initializeDependencies();

  final locationService = LocationService();
  locationService.register(
    getIt,
  );

  final repository = WeatherRepository();
  repository.register(
    getIt,
  );
  await repository.initializeDependencies();

  runApp(
    const WeatherApp(),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({
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
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
