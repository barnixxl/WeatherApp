import 'package:json_annotation/json_annotation.dart';

import '../../../models/weather_data.dart';
import 'main_data_from_network.dart';
import 'weather_info_from_network.dart';
import 'wind_data_from_network.dart';

part 'weather_item_from_network.g.dart';

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class WeatherItemFromNetwork {
  @JsonKey(name: 'dt')
  final int? dt;
  @JsonKey(name: 'main')
  final MainDataFromNetwork? main;
  @JsonKey(name: 'weather')
  final List<WeatherInfoFromNetwork>? weather;
  @JsonKey(name: 'wind')
  final WindDataFromNetwork? wind;
  @JsonKey(name: 'dt_txt')
  final String? dtTxt;

  WeatherItemFromNetwork({
    this.dt,
    this.main,
    this.weather,
    this.wind,
    this.dtTxt,
  });

  factory WeatherItemFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WeatherItemFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'WeatherItemFromNetwork('
      'dt: $dt,'
      'main: $main,'
      'weather: $weather,'
      'wind: $wind,'
      'dtTxt: $dtTxt,'
      ')';

  WeatherData toDomain() {
    return WeatherData(
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        (dt ?? 0) * 1000,
      ),
      temperature: main?.temp ?? 0.0,
      weatherMain: weather?.firstOrNull?.main ?? '',
      weatherDescription: weather?.firstOrNull?.description ?? '',
      weatherIcon: weather?.firstOrNull?.icon ?? '',
      windSpeed: wind?.speed ?? 0.0,
      humidity: main?.humidity ?? 0,
    );
  }
}
