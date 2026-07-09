// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponseFromNetwork _$WeatherResponseFromNetworkFromJson(
        Map<String, dynamic> json) =>
    WeatherResponseFromNetwork(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) =>
              HourlyForecastItemFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: json['city'] == null
          ? null
          : CityDataFromNetwork.fromJson(json['city'] as Map<String, dynamic>),
    );
