import '../resources/images/app_images/app_images.dart';

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
        return AppImages.sun;
      case WeatherStateAssets.moon:
        return AppImages.moon;
      case WeatherStateAssets.sunBehindCloud:
        return AppImages.sunBehindCloud;
      case WeatherStateAssets.moonBehindCloud:
        return AppImages.moonBehindCloud;
      case WeatherStateAssets.greyClouds:
        return AppImages.greyClouds;
      case WeatherStateAssets.greyCloudsNight:
        return AppImages.greyCloudsNight;
      case WeatherStateAssets.darkClouds:
        return AppImages.darkClouds;
      case WeatherStateAssets.darkCloudsNight:
        return AppImages.darkCloudsNight;
      case WeatherStateAssets.rain:
        return AppImages.rain;
      case WeatherStateAssets.rainNight:
        return AppImages.rainNight;
      case WeatherStateAssets.sunRain:
        return AppImages.sunRain;
      case WeatherStateAssets.sunRainNight:
        return AppImages.sunRainNight;
      case WeatherStateAssets.thunderstorm:
        return AppImages.thunderstorm;
      case WeatherStateAssets.thunderstormNight:
        return AppImages.thunderstormNight;
      case WeatherStateAssets.snow:
        return AppImages.snow;
      case WeatherStateAssets.snowNight:
        return AppImages.snowNight;
      case WeatherStateAssets.fog:
        return AppImages.fog;
      case WeatherStateAssets.fogNight:
        return AppImages.fogNight;
      case WeatherStateAssets.unknown:
        return AppImages.unknown;
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
