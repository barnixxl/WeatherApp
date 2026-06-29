import 'hour_weather.dart';

class DayWeather {
  final DateTime date;
  final List<HourWeather> hourlyData;
  final double dayMinTemp;
  final double dayMaxTemp;

  const DayWeather({
    required this.date,
    required this.hourlyData,
    required this.dayMinTemp,
    required this.dayMaxTemp,
  });
}
