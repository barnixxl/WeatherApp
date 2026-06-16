import 'package:json_annotation/json_annotation.dart';

import 'city_data_from_network.dart';
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

  @override
  String toString() => 'WeatherResponseFromNetwork('
      'list: $list,'
      'city: $city,'
      ')';
}
