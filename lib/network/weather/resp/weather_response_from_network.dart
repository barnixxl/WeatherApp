import 'package:json_annotation/json_annotation.dart';

import 'city/city_data_from_network.dart';
import 'items/hourly_forecast_item_from_network.dart';

part 'weather_response_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
)
class WeatherResponseFromNetwork {
  final List<HourlyForecastItemFromNetwork>? list;
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
