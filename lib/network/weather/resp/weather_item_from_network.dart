import 'package:json_annotation/json_annotation.dart';

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
      ' main: $main,'
      ' weather: $weather,'
      ' wind: $wind,'
      ' dtTxt: $dtTxt,'
      ')';
}

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class MainDataFromNetwork {
  @JsonKey(name: 'temp')
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'temp_max')
  final double? tempMax;
  @JsonKey(name: 'humidity')
  final int? humidity;

  MainDataFromNetwork({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.humidity,
  });

  factory MainDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'MainDataFromNetwork(temp: $temp,'
      ' feelsLike: $feelsLike,'
      ' tempMin: $tempMin,'
      ' tempMax: $tempMax,'
      ' humidity: $humidity,'
      ')';
}

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class WeatherInfoFromNetwork {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'main')
  final String? main;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'icon')
  final String? icon;

  WeatherInfoFromNetwork({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory WeatherInfoFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'WeatherInfoFromNetwork('
      'id: $id,'
      ' main: $main,'
      ' description: $description,'
      ' icon: $icon,'
      ')';
}

@JsonSerializable(
  createToJson: false,
  explicitToJson: false,
)
class WindDataFromNetwork {
  @JsonKey(
    name: 'speed',
  )
  final double? speed;

  WindDataFromNetwork({
    this.speed,
  });

  factory WindDataFromNetwork.fromJson(Map<String, dynamic> json) =>
      _$WindDataFromNetworkFromJson(
        json,
      );

  @override
  String toString() => 'WindDataFromNetwork('
      'speed: $speed, '
      ')';
}
