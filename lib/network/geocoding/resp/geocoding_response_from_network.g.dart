// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_response_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingResponseFromNetwork _$GeocodingResponseFromNetworkFromJson(
        Map<String, dynamic> json) =>
    GeocodingResponseFromNetwork(
      name: json['name'] as String?,
      localNames: json['local_names'] as Map<String, dynamic>?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      country: json['country'] as String?,
    );
