// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_item_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastItemFromNetwork _$ForecastItemFromNetworkFromJson(
        Map<String, dynamic> json) =>
    ForecastItemFromNetwork(
      dt: (json['dt'] as num?)?.toInt(),
      main: json['main'] == null
          ? null
          : MainDataFromNetwork.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map(
              (e) => WeatherInfoFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList(),
      wind: json['wind'] == null
          ? null
          : WindDataFromNetwork.fromJson(json['wind'] as Map<String, dynamic>),
      dtTxt: json['dt_txt'] as String?,
    );

MainDataFromNetwork _$MainDataFromNetworkFromJson(Map<String, dynamic> json) =>
    MainDataFromNetwork(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      tempMin: (json['temp_min'] as num?)?.toDouble(),
      tempMax: (json['temp_max'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toInt(),
    );

WeatherInfoFromNetwork _$WeatherInfoFromNetworkFromJson(
        Map<String, dynamic> json) =>
    WeatherInfoFromNetwork(
      id: (json['id'] as num?)?.toInt(),
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

WindDataFromNetwork _$WindDataFromNetworkFromJson(Map<String, dynamic> json) =>
    WindDataFromNetwork(
      speed: (json['speed'] as num?)?.toDouble(),
    );
