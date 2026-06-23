import 'weather_data.dart';

class WeatherForecastData {
  final List<WeatherData> weatherData;
  final String cityName;
  final double latitude;
  final double longitude;

  const WeatherForecastData({
    required this.weatherData,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => 'WeatherForecastData('
      'weatherData: $weatherData,'
      ' cityName: $cityName,'
      ' latitude: $latitude,'
      ' longitude: $longitude,'
      ')';
}
