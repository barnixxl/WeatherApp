import 'package:json_annotation/json_annotation.dart';

import '../data/main_data_from_network.dart';
import '../icon/weather_icon_from_network.dart';

part 'hourly_forecast_item_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class HourlyForecastItemFromNetwork {
  final int? dt;
  final MainDataFromNetwork? main;
  final List<WeatherIconFromNetwork>? weather;

  HourlyForecastItemFromNetwork({
    this.dt,
    this.main,
    this.weather,
  });

  factory HourlyForecastItemFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastItemFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'HourlyForecastItemFromNetwork('
      'dt: $dt,'
      'main: $main,'
      'weather: $weather,'
      ')';
}
