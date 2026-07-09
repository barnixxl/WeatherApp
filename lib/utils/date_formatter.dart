import 'package:intl/intl.dart';

extension DateTimeFormattingUtil on DateTime? {
  static final DateFormat dayMonthYearTextDateFormat =
      DateFormat('d MMMM y', 'ru');
  static final DateFormat dayOfWeekFormat = DateFormat('EEEE', 'ru');
  static final DateFormat hourMinuteFormat = DateFormat('HH:mm', 'ru');

  String? toDayMonthYearTextDateFormat() {
    final self = this;
    if (self != null) {
      return dayMonthYearTextDateFormat.format(
        self,
      );
    }
    return null;
  }

  String? toDayOfWeekFormat() {
    final self = this;
    if (self != null) {
      return dayOfWeekFormat.format(
        self,
      );
    }
    return null;
  }

  String? toHourMinuteFormat() {
    final self = this;
    if (self != null) {
      return hourMinuteFormat.format(
        self,
      );
    }
    return null;
  }
}
