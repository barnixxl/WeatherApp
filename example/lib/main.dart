import 'package:currency_converter/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'network/currency/currency_api.dart';
import 'network/currency_rate_network.dart';
import 'repository/currency_repository.dart';
import 'resources/colors/app_colors.dart';
import 'resources/strings/app_localizations.dart';

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
  final network = CurrencyRateNetwork();
  network.register(
    getIt,
  );
  await network.initializeDependencies();
  final api = CurrencyApi();
  api.register(
    getIt,
  );
  await api.initializeDependencies();
  final repository = CurrencyRepository();
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
