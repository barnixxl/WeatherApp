import 'package:json_annotation/json_annotation.dart';

part 'weather_info_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class WeatherInfoFromNetwork {
  @JsonKey(name: 'main')
  final String? main;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'icon')
  final String? icon;

  WeatherInfoFromNetwork({
    this.main,
    this.description,
    this.icon,
  });

  factory WeatherInfoFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'WeatherInfoFromNetwork('
      'main: $main,'
      'description: $description,'
      'icon: $icon,'
      ')';
}
