// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get app_title => 'Прогноз погоды';

  @override
  String get home_title => 'Прогноз погоды';

  @override
  String updated_at(String date) {
    return 'Обновлено: $date';
  }

  @override
  String get loading_weather => 'Загрузка прогноза погоды...';

  @override
  String get error => 'Ошибка...';

  @override
  String get geo_error =>
      'Нет доступа к геолокации. Включи GPS и попробуй снова.';

  @override
  String get retry => 'Повторить';

  @override
  String get common_absent_date => 'Дата отсутствует';

  @override
  String get error_timeout => 'Время соединения вышло';

  @override
  String get error_no_internet => 'Проверьте соединение с интернетом';

  @override
  String error_server(int statusCode) {
    return 'Ошибка сервера: $statusCode';
  }

  @override
  String error_bad_response(int statusCode) {
    return 'Неверный ответ сервера: $statusCode';
  }

  @override
  String get error_cancelled => 'Запрос отменен';

  @override
  String get error_unknown => 'Неизвестная ошибка сети';

  @override
  String get error_parsing => 'Ошибка парсинга данных';

  @override
  String get error_no_data => 'Нет данных';

  @override
  String get common_unknow_city_name => 'Неизвестное название города';

  @override
  String get current_location => 'Текущее местоположение';

  @override
  String temperature_format(String temp) {
    return '$temp°C';
  }
}
