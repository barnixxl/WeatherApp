import 'weather_data.dart';

class DayWeather {
  final DateTime date;
  final List<WeatherData> hourlyData;

  DayWeather({
    required this.date,
    required this.hourlyData,
  });

  @override
  String toString() => 'DayWeather('
      'date: $date,'
      ' hourlyData: $hourlyData,'
      ')';
}
