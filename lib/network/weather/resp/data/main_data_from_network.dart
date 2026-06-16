import 'package:json_annotation/json_annotation.dart';

part 'main_data_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class MainDataFromNetwork {
  @JsonKey(name: 'temp')
  final double? temp;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'temp_max')
  final double? tempMax;
  @JsonKey(name: 'humidity')
  final int? humidity;

  MainDataFromNetwork({
    this.temp,
    this.tempMin,
    this.tempMax,
    this.humidity,
  });

  factory MainDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'MainDataFromNetwork('
      'temp: $temp,'
      'tempMin: $tempMin,'
      'tempMax: $tempMax,'
      'humidity: $humidity,'
      ')';
}
