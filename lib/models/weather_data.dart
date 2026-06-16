class WeatherData {
  final DateTime dateTime;
  final double temperature;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final double windSpeed;
  final int humidity;

  const WeatherData({
    required this.dateTime,
    required this.temperature,
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
      ' weatherMain: $weatherMain,'
      ' weatherDescription: $weatherDescription,'
      ' weatherIcon: $weatherIcon,'
      ' windSpeed: $windSpeed,'
      ' humidity: $humidity,'
      ')';

  @override
  bool operator ==(
    Object other,
  ) =>
      identical(
        this,
        other,
      ) ||
      other is WeatherData &&
          dateTime == other.dateTime &&
          temperature == other.temperature &&
          weatherMain == other.weatherMain &&
          weatherDescription == other.weatherDescription &&
          weatherIcon == other.weatherIcon &&
          windSpeed == other.windSpeed &&
          humidity == other.humidity;

  @override
  int get hashCode => Object.hash(
        dateTime,
        temperature,
        weatherMain,
        weatherDescription,
        weatherIcon,
        windSpeed,
        humidity,
      );
}
