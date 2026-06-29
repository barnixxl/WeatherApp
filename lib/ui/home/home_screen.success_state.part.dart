part of 'home_screen.dart';

Widget _buildSuccessWidget({
  required List<DayWeather> dayWeather,
  required double latitude,
  required double longitude,
}) {
  return ListView(
    padding: const EdgeInsets.all(
      8,
    ),
    children: [
      for (final item in dayWeather)
        DayWeatherItem(
          date: item.date,
          dayMinTemp: item.dayMinTemp,
          dayMaxTemp: item.dayMaxTemp,
          hourlyData: item.hourlyData,
        ),
      WeatherMapWidget(
        latitude: latitude,
        longitude: longitude,
      ),
    ],
  );
}
