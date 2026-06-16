// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_data_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityDataFromNetwork _$CityDataFromNetworkFromJson(Map<String, dynamic> json) =>
    CityDataFromNetwork(
      name: json['name'] as String?,
      coord: json['coord'] == null
          ? null
          : CoordDataFromNetwork.fromJson(
              json['coord'] as Map<String, dynamic>),
    );
