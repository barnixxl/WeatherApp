import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'strings/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @app_title.
  ///
  /// In ru, this message translates to:
  /// **'Конвертер валют'**
  String get app_title;

  /// No description provided for @home_title.
  ///
  /// In ru, this message translates to:
  /// **'Курсы валют НБРБ'**
  String get home_title;

  /// No description provided for @updated_at.
  ///
  /// In ru, this message translates to:
  /// **'Обновлено: {date}'**
  String updated_at(String date);

  /// No description provided for @loading_currencies.
  ///
  /// In ru, this message translates to:
  /// **'Загрузка курсов валют...'**
  String get loading_currencies;

  /// No description provided for @error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка...'**
  String get error;

  /// No description provided for @retry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get retry;

  /// No description provided for @base_currency_name.
  ///
  /// In ru, this message translates to:
  /// **'Белорусский рубль (BYN)'**
  String get base_currency_name;

  /// No description provided for @exchange_rate.
  ///
  /// In ru, this message translates to:
  /// **'Курс'**
  String get exchange_rate;

  /// No description provided for @base_cur_code.
  ///
  /// In ru, this message translates to:
  /// **'BYN'**
  String get base_cur_code;

  /// No description provided for @base_currency.
  ///
  /// In ru, this message translates to:
  /// **'Базовая валюта'**
  String get base_currency;

  /// No description provided for @update_date.
  ///
  /// In ru, this message translates to:
  /// **'Дата обновления'**
  String get update_date;

  /// No description provided for @common_absent_date.
  ///
  /// In ru, this message translates to:
  /// **'Дата отсутствует'**
  String get common_absent_date;

  /// No description provided for @common_unknown_currency_name.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестная валюта'**
  String get common_unknown_currency_name;

  /// No description provided for @amount_in.
  ///
  /// In ru, this message translates to:
  /// **'Сумма в {currency}'**
  String amount_in(String currency);

  /// No description provided for @common_scale_equals_rate_byn.
  ///
  /// In ru, this message translates to:
  /// **'{scale} {code} = {rate} BYN'**
  String common_scale_equals_rate_byn(int scale, String code, String rate);

  /// No description provided for @converted_result.
  ///
  /// In ru, this message translates to:
  /// **'{amount} {currencyName} ({currencyCode})'**
  String converted_result(
      String amount, String currencyName, String currencyCode);

  /// No description provided for @converted_result_reverse.
  ///
  /// In ru, this message translates to:
  /// **'{amount} {currencyName}'**
  String converted_result_reverse(String amount, String currencyName);

  /// No description provided for @error_timeout.
  ///
  /// In ru, this message translates to:
  /// **'Время соединения вышло'**
  String get error_timeout;

  /// No description provided for @error_no_internet.
  ///
  /// In ru, this message translates to:
  /// **'Проверьте соединение с интернетом'**
  String get error_no_internet;

  /// No description provided for @error_server.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка сервера: {statusCode}'**
  String error_server(int statusCode);

  /// No description provided for @error_bad_response.
  ///
  /// In ru, this message translates to:
  /// **'Неверный ответ сервера: {statusCode}'**
  String error_bad_response(int statusCode);

  /// No description provided for @error_cancelled.
  ///
  /// In ru, this message translates to:
  /// **'Запрос отменен'**
  String get error_cancelled;

  /// No description provided for @error_unknown.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестная ошибка сети'**
  String get error_unknown;

  /// No description provided for @error_parsing.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка парсинга данных'**
  String get error_parsing;

  /// No description provided for @error_no_data.
  ///
  /// In ru, this message translates to:
  /// **'Нет закэшированных данных'**
  String get error_no_data;

  /// No description provided for @error_load_failed.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка загрузки данных'**
  String get error_load_failed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
