class WeatherIconMapper {
  static const _basePath = 'assets/images/weather_state_images';

  static String getIconPath(String iconCode) {
    switch (iconCode) {
      case '01d':
        return '$_basePath/sun.png';
      case '01n':
        return '$_basePath/moon.png';
      case '02d':
        return '$_basePath/sun_behind_cloud.png';
      case '02n':
        return '$_basePath/moon_behind_cloud.png';
      case '03d':
        return '$_basePath/grey_clouds.png';
      case '03n':
        return '$_basePath/grey_clouds_night.png';
      case '04d':
        return '$_basePath/dark_clouds.png';
      case '04n':
        return '$_basePath/dark_clouds_night.png';
      case '09d':
        return '$_basePath/rain.png';
      case '09n':
        return '$_basePath/rain_night.png';
      case '10d':
        return '$_basePath/sun_rain.png';
      case '10n':
        return '$_basePath/sun_rain_night.png';
      case '11d':
        return '$_basePath/thunderstorm.png';
      case '11n':
        return '$_basePath/thunderstorm_night.png';
      case '13d':
        return '$_basePath/snow.png';
      case '13n':
        return '$_basePath/snow_night.png';
      case '50d':
        return '$_basePath/fog.png';
      case '50n':
        return '$_basePath/fog_night.png';
      default:
        return '$_basePath/sun.png';
    }
  }
}
