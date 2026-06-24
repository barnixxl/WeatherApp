part of 'home_screen.dart';

Widget _buildSuccessWidget({
  required List<DayWeather> dayWeather,
  required double latitude,
  required double longitude,
}) {
  return ListView.builder(
    padding: const EdgeInsets.all(
      8,
    ),
    itemCount: dayWeather.length + 1,
    itemBuilder: (
      context,
      index,
    ) {
      if (index == dayWeather.length) {
        return WeatherMapWidget(
          latitude: latitude,
          longitude: longitude,
        );
      }
      final item = dayWeather[index];
      return DayWeatherItem(
        date: item.date,
        dayMinTemp: item.dayMinTemp,
        dayMaxTemp: item.dayMaxTemp,
        hourlyData: item.hourlyData,
      );
    },
  );
}
