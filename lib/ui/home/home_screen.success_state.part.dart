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
      return index == dayWeather.length
          ? WeatherMapWidget(
              latitude: latitude,
              longitude: longitude,
            )
          : DayWeatherItem(
              date: dayWeather[index].date,
              dayMinTemp: dayWeather[index].dayMinTemp,
              dayMaxTemp: dayWeather[index].dayMaxTemp,
              hourlyData: dayWeather[index].hourlyData,
            );
    },
  );
}
