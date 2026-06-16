import 'package:json_annotation/json_annotation.dart';

part 'city_data_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class CityDataFromNetwork {
  @JsonKey(name: 'name')
  final String? name;

  CityDataFromNetwork({
    this.name,
  });

  factory CityDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$CityDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'CityDataFromNetwork('
      'name: $name,'
      ')';
}
