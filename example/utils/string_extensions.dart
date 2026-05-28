import 'date_formatter.dart';

extension StringNullableUtils on String? {
  DateTime? toDayMonthYearDateParse() {
    final self = this;
    if (self != null) {
      try {
        final parsedIso = DateTime.tryParse(
          self,
        );
        if (parsedIso != null) {
          return parsedIso;
        }
        return DateUtils.dayMonthYearTextDateFormat.parse(
          self,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
