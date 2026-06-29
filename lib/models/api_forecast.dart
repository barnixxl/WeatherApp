import 'hour_weather.dart';

class ApiForecast {
  final List<HourWeather> weatherData;
  final String cityName;
  final double latitude;
  final double longitude;

  const ApiForecast({
    required this.weatherData,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });
}
