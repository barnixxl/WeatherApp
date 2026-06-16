import 'package:flutter/foundation.dart';

import 'weather_data.dart';

class DayWeather {
  final DateTime date;
  final List<WeatherData> hourlyData;
  final double dayMinTemp;
  final double dayMaxTemp;

  const DayWeather({
    required this.date,
    required this.hourlyData,
    required this.dayMinTemp,
    required this.dayMaxTemp,
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
          dayMinTemp == other.dayMinTemp &&
          dayMaxTemp == other.dayMaxTemp &&
          listEquals(
            hourlyData,
            other.hourlyData,
          );

  @override
  int get hashCode => Object.hash(
        date,
        dayMinTemp,
        dayMaxTemp,
        Object.hashAll(
          hourlyData,
        ),
      );
}
