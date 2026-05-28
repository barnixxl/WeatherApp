import 'weather_data.dart';

class DayForecast {
  final DateTime date;
  final List<WeatherData> hourlyData;

  DayForecast({
    required this.date,
    required this.hourlyData,
  });
}
