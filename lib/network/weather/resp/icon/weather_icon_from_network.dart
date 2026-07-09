import 'package:json_annotation/json_annotation.dart';

part 'weather_icon_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class WeatherIconFromNetwork {
  final String? icon;

  WeatherIconFromNetwork({
    this.icon,
  });

  factory WeatherIconFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WeatherIconFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'WeatherIconFromNetwork('
      'icon: $icon,'
      ')';
}
