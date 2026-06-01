import 'package:json_annotation/json_annotation.dart';

import 'weather_item_from_network.dart';

part 'weather_response_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class WeatherResponseFromNetwork {
  @JsonKey(name: 'list')
  final List<WeatherItemFromNetwork>? list;
  @JsonKey(name: 'city')
  final CityDataFromNetwork? city;

  WeatherResponseFromNetwork({
    this.list,
    this.city,
  });

  factory WeatherResponseFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromNetworkFromJson(
        json,
      );
}

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
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
}

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class CoordDataFromNetwork {
  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'lon')
  final double? lon;

  CoordDataFromNetwork({
    this.lat,
    this.lon,
  });

  factory CoordDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$CoordDataFromNetworkFromJson(
        json,
      );
}
