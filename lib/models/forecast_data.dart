import 'day_weather.dart';

class ForecastData {
  final List<DayWeather> dayWeather;
  final String cityName;
  final double latitude;
  final double longitude;

  const ForecastData({
    required this.dayWeather,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });
}
