import '../main.dart';
import '../network/weather/resp/weather_response_from_network.dart';
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

  static ForecastResponse fromNetworkModel(
    WeatherResponseFromNetwork response,
    double lat,
    double lon,
  ) {
    return ForecastResponse(
      weatherData: (response.list ?? [])
          .where((e) => e.dt != null)
          .map((e) => HourWeather.fromNetworkModel(e))
          .toList(),
      cityName: response.city?.name ?? strings.common_unknown_city_name,
      latitude: response.city?.coord?.lat ?? lat,
      longitude: response.city?.coord?.lon ?? lon,
    );
  }
}
