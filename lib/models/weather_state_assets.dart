import '../resources/images/weather_state_images/weather_state_images.dart';

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
  fogNight,
  unknown;

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
      case WeatherStateAssets.unknown:
        return WeatherStateImages.unknown;
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
        return WeatherStateAssets.unknown;
    }
  }
}
