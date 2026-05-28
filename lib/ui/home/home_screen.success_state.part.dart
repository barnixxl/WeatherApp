part of 'home_screen.dart';

Widget _buildSuccessWidget({
  required List<DayForecast> forecasts,
  required double latitude,
  required double longitude,
}) {
  return ListView.builder(
    padding: const EdgeInsets.all(
      8,
    ),
    itemCount: forecasts.length + 1,
    itemBuilder: (
      context,
      index,
    ) {
      if (index < forecasts.length) {
        final forecast = forecasts[index];
        return DayForecastItem(
          forecast: forecast,
        );
      } else {
        return WeatherMapWidget(
          latitude: latitude,
          longitude: longitude,
        );
      }
    },
  );
}
