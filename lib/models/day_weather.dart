import 'weather_data.dart';

class DayWeather {
  final DateTime date;
  final List<WeatherData> hourlyData;
  final double dayMinTemp;
  final double dayMaxTemp;

  const DayWeather({
    required this.date,
    required this.hourlyData,
    required this.dayMinTemp,
    required this.dayMaxTemp,
  });
}
