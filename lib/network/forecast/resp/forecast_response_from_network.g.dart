// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_response_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastResponseFromNetwork _$ForecastResponseFromNetworkFromJson(
        Map<String, dynamic> json) =>
    ForecastResponseFromNetwork(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) =>
              ForecastItemFromNetwork.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: json['city'] == null
          ? null
          : CityDataFromNetwork.fromJson(json['city'] as Map<String, dynamic>),
    );

CityDataFromNetwork _$CityDataFromNetworkFromJson(Map<String, dynamic> json) =>
    CityDataFromNetwork(
      name: json['name'] as String?,
      coord: json['coord'] == null
          ? null
          : CoordDataFromNetwork.fromJson(
              json['coord'] as Map<String, dynamic>),
    );

CoordDataFromNetwork _$CoordDataFromNetworkFromJson(
        Map<String, dynamic> json) =>
    CoordDataFromNetwork(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );
