// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_items_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherItemFromNetwork _$WeatherItemFromNetworkFromJson(
        Map<String, dynamic> json) =>
    WeatherItemFromNetwork(
      dt: (json['dt'] as num?)?.toInt(),
      main: json['main'] == null
          ? null
          : MainDataFromNetwork.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map(
              (e) => WeatherInfoFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
