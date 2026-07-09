// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_item_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyForecastItemFromNetwork _$HourlyForecastItemFromNetworkFromJson(
        Map<String, dynamic> json) =>
    HourlyForecastItemFromNetwork(
      dt: (json['dt'] as num?)?.toInt(),
      main: json['main'] == null
          ? null
          : MainDataFromNetwork.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map(
              (e) => WeatherIconFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
