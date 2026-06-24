class WeatherData {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weatherMain;
  final String weatherDescription;
  final String weatherImage;
  final double windSpeed;

  const WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherImage,
    required this.windSpeed,
  });

  @override
  String toString() => 'WeatherData('
      'dateTime: $dateTime,'
      ' temperature: $temperature,'
      ' tempMin: $tempMin,'
      ' tempMax: $tempMax,'
      ' weatherMain: $weatherMain,'
      ' weatherDescription: $weatherDescription,'
      ' weatherIcon: $weatherImage,'
      ' windSpeed: $windSpeed,'
      ')';
}
