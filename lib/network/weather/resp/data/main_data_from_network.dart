import 'package:json_annotation/json_annotation.dart';

part 'main_data_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class MainDataFromNetwork {
  final double? temp;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'temp_max')
  final double? tempMax;

  MainDataFromNetwork({
    this.temp,
    this.tempMin,
    this.tempMax,
  });

  factory MainDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'MainDataFromNetwork('
      'temp: $temp,'
      'tempMin: $tempMin,'
      'tempMax: $tempMax'
      ')';
}
