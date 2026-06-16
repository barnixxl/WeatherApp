// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherInfoFromNetwork _$WeatherInfoFromNetworkFromJson(
        Map<String, dynamic> json) =>
    WeatherInfoFromNetwork(
      id: (json['id'] as num?)?.toInt(),
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );
