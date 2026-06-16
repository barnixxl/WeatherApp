import 'package:json_annotation/json_annotation.dart';

import '../../../models/coordinates.dart';

part 'geocoding_response_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class GeocodingResponseFromNetwork {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'local_names')
  final Map<String, String>? localNames;
  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'lon')
  final double? lon;
  @JsonKey(name: 'country')
  final String? country;

  GeocodingResponseFromNetwork({
    this.name,
    this.localNames,
    this.lat,
    this.lon,
    this.country,
  });

  factory GeocodingResponseFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResponseFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'GeocodingResponseFromNetwork('
      'name: $name,'
      ' localNames: $localNames,'
      ' lat: $lat,'
      ' lon: $lon,'
      ' country: $country,'
      ')';

  Coordinates toDomain() {
    return Coordinates(
      lat: lat ?? 0.0,
      lon: lon ?? 0.0,
    );
  }
}
