import '../network/weather/resp/items/weather_items_from_network.dart';
import '../resources/images/weather_state_images/weather_state_images.dart';
import '../utils/int_extensions.dart';

class HourWeather {
  final DateTime? dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String weatherMain;
  final WeatherStateAssets weatherState;

  const HourWeather({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.weatherMain,
    required this.weatherState,
  });

  static HourWeather fromNetworkModel(
    WeatherItemFromNetwork item,
  ) {
    return HourWeather(
      dateTime: item.dt?.toDateTimeFromUnixSeconds(),
      temperature: item.main?.temp ?? 0.0,
      tempMin: item.main?.tempMin ?? 0.0,
      tempMax: item.main?.tempMax ?? 0.0,
      weatherMain: item.weather?.firstOrNull?.main ?? '',
      weatherState: WeatherStateAssets.fromCode(
        item.weather?.firstOrNull?.icon ?? '',
      ),
    );
  }
}

enum WeatherStateAssets {
  sun,
  moon,
  sunBehindCloud,
  moonBehindCloud,
  greyClouds,
  greyCloudsNight,
  darkClouds,
  darkCloudsNight,
  rain,
  rainNight,
  sunRain,
  sunRainNight,
  thunderstorm,
  thunderstormNight,
  snow,
  snowNight,
  fog,
  fogNight;

  String get imagePath {
    switch (this) {
      case WeatherStateAssets.sun:
        return WeatherStateImages.sun;
      case WeatherStateAssets.moon:
        return WeatherStateImages.moon;
      case WeatherStateAssets.sunBehindCloud:
        return WeatherStateImages.sunBehindCloud;
      case WeatherStateAssets.moonBehindCloud:
        return WeatherStateImages.moonBehindCloud;
      case WeatherStateAssets.greyClouds:
        return WeatherStateImages.greyClouds;
      case WeatherStateAssets.greyCloudsNight:
        return WeatherStateImages.greyCloudsNight;
      case WeatherStateAssets.darkClouds:
        return WeatherStateImages.darkClouds;
      case WeatherStateAssets.darkCloudsNight:
        return WeatherStateImages.darkCloudsNight;
      case WeatherStateAssets.rain:
        return WeatherStateImages.rain;
      case WeatherStateAssets.rainNight:
        return WeatherStateImages.rainNight;
      case WeatherStateAssets.sunRain:
        return WeatherStateImages.sunRain;
      case WeatherStateAssets.sunRainNight:
        return WeatherStateImages.sunRainNight;
      case WeatherStateAssets.thunderstorm:
        return WeatherStateImages.thunderstorm;
      case WeatherStateAssets.thunderstormNight:
        return WeatherStateImages.thunderstormNight;
      case WeatherStateAssets.snow:
        return WeatherStateImages.snow;
      case WeatherStateAssets.snowNight:
        return WeatherStateImages.snowNight;
      case WeatherStateAssets.fog:
        return WeatherStateImages.fog;
      case WeatherStateAssets.fogNight:
        return WeatherStateImages.fogNight;
    }
  }

  static WeatherStateAssets fromCode(
    String code,
  ) {
    switch (code) {
      case '01d':
        return WeatherStateAssets.sun;
      case '01n':
        return WeatherStateAssets.moon;
      case '02d':
        return WeatherStateAssets.sunBehindCloud;
      case '02n':
        return WeatherStateAssets.moonBehindCloud;
      case '03d':
        return WeatherStateAssets.greyClouds;
      case '03n':
        return WeatherStateAssets.greyCloudsNight;
      case '04d':
        return WeatherStateAssets.darkClouds;
      case '04n':
        return WeatherStateAssets.darkCloudsNight;
      case '09d':
        return WeatherStateAssets.rain;
      case '09n':
        return WeatherStateAssets.rainNight;
      case '10d':
        return WeatherStateAssets.sunRain;
      case '10n':
        return WeatherStateAssets.sunRainNight;
      case '11d':
        return WeatherStateAssets.thunderstorm;
      case '11n':
        return WeatherStateAssets.thunderstormNight;
      case '13d':
        return WeatherStateAssets.snow;
      case '13n':
        return WeatherStateAssets.snowNight;
      case '50d':
        return WeatherStateAssets.fog;
      case '50n':
        return WeatherStateAssets.fogNight;
      default:
        return WeatherStateAssets.sun;
    }
  }
}
