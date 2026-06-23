import 'package:json_annotation/json_annotation.dart';

import 'coord_data_from_network.dart';

part 'city_data_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class CityDataFromNetwork {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'coord')
  final CoordDataFromNetwork? coord;

  CityDataFromNetwork({
    this.name,
    this.coord,
  });

  factory CityDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$CityDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'CityDataFromNetwork('
      'name: $name,'
      'coord: $coord,'
      ')';
}
