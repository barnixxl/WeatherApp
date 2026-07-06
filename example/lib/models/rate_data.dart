import '../main.dart';
import '../network/currency/resp/rate_data_from_network.dart';
import '../utils/string_extensions.dart';

class RateData {
  final String code;
  final String name;
  final double rate;
  final DateTime? date;
  final int scale;

  RateData({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
    required this.scale,
  });

  static RateData fromNetworkModel(
    RateDataFromNetwork model,
  ) {
    return RateData(
      code: model.curAbbreviation ?? '',
      name: model.curName ?? strings.common_unknown_currency_name,
      rate: model.curOfficialRate ?? 0.0,
      date: model.date?.toDayMonthYearDateParse(),
      scale: (model.curScale ?? 1).toInt(),
    );
  }
}
