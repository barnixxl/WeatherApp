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
        return AppImages.icSun;
      case WeatherStateAssets.moon:
        return AppImages.icMoon;
      case WeatherStateAssets.sunBehindCloud:
        return AppImages.icSunBehindCloud;
      case WeatherStateAssets.moonBehindCloud:
        return AppImages.icMoonBehindCloud;
      case WeatherStateAssets.greyClouds:
        return AppImages.icGreyClouds;
      case WeatherStateAssets.greyCloudsNight:
        return AppImages.icGreyCloudsNight;
      case WeatherStateAssets.darkClouds:
        return AppImages.icDarkClouds;
      case WeatherStateAssets.darkCloudsNight:
        return AppImages.icDarkCloudsNight;
      case WeatherStateAssets.rain:
        return AppImages.icRain;
      case WeatherStateAssets.rainNight:
        return AppImages.icRainNight;
      case WeatherStateAssets.sunRain:
        return AppImages.icSunRain;
      case WeatherStateAssets.sunRainNight:
        return AppImages.icSunRainNight;
      case WeatherStateAssets.thunderstorm:
        return AppImages.icThunderstorm;
      case WeatherStateAssets.thunderstormNight:
        return AppImages.icThunderstormNight;
      case WeatherStateAssets.snow:
        return AppImages.icSnow;
      case WeatherStateAssets.snowNight:
        return AppImages.icSnowNight;
      case WeatherStateAssets.fog:
        return AppImages.icFog;
      case WeatherStateAssets.fogNight:
        return AppImages.icFogNight;
      case WeatherStateAssets.unknown:
        return AppImages.icUnknown;
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
