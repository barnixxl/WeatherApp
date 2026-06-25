import 'day_weather.dart';

class ForecastResult {
  final List<DayWeather> dayWeather;
  final String cityName;
  final double latitude;
  final double longitude;

  const ForecastResult({
    required this.dayWeather,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });
}
