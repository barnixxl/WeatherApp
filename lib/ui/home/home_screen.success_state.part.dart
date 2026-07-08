part of 'home_screen.dart';

Widget _buildSuccessWidget({
  required List<DayWeather> dayWeather,
}) {
  return ListView.builder(
    padding: const EdgeInsets.all(
      8,
    ),
    itemCount: dayWeather.length,
    itemBuilder: (
      _,
      index,
    ) {
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
