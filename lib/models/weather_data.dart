import '../network/weather/resp/items/weather_items_from_network.dart';
import '../utils/int_extensions.dart';

class WeatherData {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weatherMain;
  final String weatherDescription;
  final String weatherImageCode;
  final double windSpeed;

  const WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherImageCode,
    required this.windSpeed,
  });

  static WeatherData fromNetworkModel(
    WeatherItemFromNetwork item,
  ) {
    return WeatherData(
      dateTime: item.dt?.toDateTimeFromUnixSeconds() ?? DateTime.now(),
      temperature: item.main?.temp ?? 0.0,
      tempMin: item.main?.tempMin ?? 0.0,
      tempMax: item.main?.tempMax ?? 0.0,
      weatherMain: item.weather?.firstOrNull?.main ?? '',
      weatherDescription: item.weather?.firstOrNull?.description ?? '',
      weatherImageCode: item.weather?.firstOrNull?.icon ?? '',
      windSpeed: item.wind?.speed ?? 0.0,
    );
  }
}
