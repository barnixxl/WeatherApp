import '../main.dart';
import '../network/weather/resp/weather_response_from_network.dart';
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

  static ApiForecast fromNetworkModel(
    WeatherResponseFromNetwork response,
  ) {
    return ApiForecast(
      weatherData: (response.list ?? [])
          .map((e) => HourWeather.fromNetworkModel(e))
          .toList(),
      cityName: response.city?.name ?? strings.common_unknow_city_name,
      latitude: response.city?.coord?.lat ?? 0.0,
      longitude: response.city?.coord?.lon ?? 0.0,
    );
  }
}
