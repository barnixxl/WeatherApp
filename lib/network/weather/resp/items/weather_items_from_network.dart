import 'package:json_annotation/json_annotation.dart';

import '../data/main_data_from_network.dart';
import '../icon/weather_icon_from_network.dart';

part 'weather_items_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class WeatherItemFromNetwork {
  @JsonKey(name: 'dt')
  final int? dt;
  @JsonKey(name: 'main')
  final MainDataFromNetwork? main;
  @JsonKey(name: 'weather')
  final List<WeatherIconFromNetwork>? weather;

  WeatherItemFromNetwork({
    this.dt,
    this.main,
    this.weather,
  });

  factory WeatherItemFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'WeatherItemFromNetwork('
      'dt: $dt,'
      'main: $main,'
      'weather: $weather,'
      ')';
}
