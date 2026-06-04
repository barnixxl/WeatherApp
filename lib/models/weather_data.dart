import '../network/weather/resp/weather_item_from_network.dart';

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

  factory WeatherData.fromNetworkModel(
    WeatherItemFromNetwork model,
  ) {
    return WeatherData(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (model.dt ?? 0) * 1000,
      ),
      temperature: model.main?.temp ?? 0.0,
      weatherMain: model.weather?.firstOrNull?.main ?? '',
      weatherDescription: model.weather?.firstOrNull?.description ?? '',
      weatherIcon: model.weather?.firstOrNull?.icon ?? '',
      windSpeed: model.wind?.speed ?? 0.0,
      humidity: model.main?.humidity ?? 0,
    );
  }
}
