import 'package:intl/intl.dart';

extension DateUtils on DateTime? {
  static final DateFormat dayMonthYearTextDateFormat =
      DateFormat('d MMMM y', 'ru');

  String? toDayMonthYearTextDateFormat() {
    final self = this;
    if (self != null) {
      return dayMonthYearTextDateFormat.format(
        self,
      );
    }
    return null;
  }
}
