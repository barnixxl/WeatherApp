// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_data_from_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateDataFromNetwork _$RateDataFromNetworkFromJson(Map<String, dynamic> json) =>
    RateDataFromNetwork(
      curID: (json['Cur_ID'] as num?)?.toInt(),
      curAbbreviation: json['Cur_Abbreviation'] as String?,
      curScale: (json['Cur_Scale'] as num?)?.toInt(),
      curName: json['Cur_Name'] as String?,
      curOfficialRate: (json['Cur_OfficialRate'] as num?)?.toDouble(),
      date: json['Date'] as String?,
    );
