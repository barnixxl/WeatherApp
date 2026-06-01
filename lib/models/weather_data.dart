class WeatherData {
  final DateTime dateTime;
  final double temperature;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;
  final int humidity;

  WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.humidity,
  });
}
