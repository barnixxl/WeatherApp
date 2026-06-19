import 'package:json_annotation/json_annotation.dart';

part 'wind_data_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class WindDataFromNetwork {
  @JsonKey(name: 'speed')
  final double? speed;

  WindDataFromNetwork({
    this.speed,
  });

  factory WindDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WindDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'WindDataFromNetwork('
      'speed: $speed,'
      ')';
}
