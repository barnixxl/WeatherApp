import '../network/weather/resp/items/hourly_forecast_item_from_network.dart';
import '../utils/int_extensions.dart';
import 'weather_state_assets.dart';

class HourWeather {
  final DateTime? dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final WeatherStateAssets weatherState;

  const HourWeather({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherState,
  });

  static HourWeather fromNetworkModel(
    HourlyForecastItemFromNetwork item,
  ) {
    return HourWeather(
      dateTime: item.dt?.toDateTimeFromUnixSeconds(),
      temperature: item.main?.temp ?? 0.0,
      tempMin: item.main?.tempMin ?? 0.0,
      tempMax: item.main?.tempMax ?? 0.0,
      weatherState: WeatherStateAssets.fromCode(
        item.weather?.firstOrNull?.icon ?? '',
      ),
    );
  }
}
