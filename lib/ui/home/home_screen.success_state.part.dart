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
      ...dayWeather.map(
        (item) => DayWeatherItem(
          dayWeather: item,
        ),
      ),
      WeatherMapWidget(
        latitude: latitude,
        longitude: longitude,
      ),
    ],
  );
}
