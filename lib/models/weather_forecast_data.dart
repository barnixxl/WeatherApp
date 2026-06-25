import '../main.dart';
import '../network/weather/resp/weather_response_from_network.dart';
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

  static WeatherForecastData fromNetworkModel(
    WeatherResponseFromNetwork response,
  ) {
    return WeatherForecastData(
      weatherData: (response.list ?? [])
          .map((e) => WeatherData.fromNetworkModel(e))
          .toList(),
      cityName: response.city?.name ?? strings.common_unknow_city_name,
      latitude: response.city?.coord?.lat ?? 0.0,
      longitude: response.city?.coord?.lon ?? 0.0,
    );
  }
}
