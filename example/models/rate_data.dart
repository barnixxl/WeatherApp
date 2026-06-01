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
}
