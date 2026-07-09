import 'package:json_annotation/json_annotation.dart';

part 'coord_data_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class CoordDataFromNetwork {
  final double? lat;
  final double? lon;

  CoordDataFromNetwork({
    this.lat,
    this.lon,
  });

  factory CoordDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$CoordDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'CoordDataFromNetwork('
      'lat: $lat,'
      'lon: $lon,'
      ')';
}
