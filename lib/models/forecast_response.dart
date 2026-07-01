import 'hour_weather.dart';

class ForecastResponse {
  final List<HourWeather> weatherData;
  final String cityName;
  final double latitude;
  final double longitude;

  const ForecastResponse({
    required this.weatherData,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });
}
