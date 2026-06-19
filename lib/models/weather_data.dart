class WeatherData {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;
  final int humidity;

  const WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.humidity,
  });

  @override
  String toString() => 'WeatherData('
      'dateTime: $dateTime,'
      ' temperature: $temperature,'
      ' tempMin: $tempMin,'
      ' tempMax: $tempMax,'
      ' weatherMain: $weatherMain,'
      ' weatherDescription: $weatherDescription,'
      ' weatherIcon: $weatherIcon,'
      ' windSpeed: $windSpeed,'
      ' humidity: $humidity,'
      ')';
}
