import 'package:flutter/foundation.dart';

import 'weather_data.dart';

class DayWeather {
  final DateTime date;
  final List<WeatherData> hourlyData;

  const DayWeather({
    required this.date,
    required this.hourlyData,
  });

  @override
  String toString() => 'DayWeather('
      'date: $date,'
      ' hourlyData: $hourlyData,'
      ')';

  @override
  bool operator ==(
    Object other,
  ) =>
      identical(
        this,
        other,
      ) ||
      other is DayWeather &&
          date == other.date &&
          listEquals(
            hourlyData,
            other.hourlyData,
          );

  @override
  int get hashCode => Object.hash(
        date,
        Object.hashAll(
          hourlyData,
        ),
      );
}
