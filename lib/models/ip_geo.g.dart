// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_geo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpGeo _$IpGeoFromJson(Map<String, dynamic> json) => IpGeo()
  ..statue = json['statue'] as String?
  ..info = json['info'] as String?
  ..infocode = json['infocode'] as String?
  ..province = json['province'] as String?
  ..city = json['city'] as String?
  ..adcode = json['adcode'] as String?
  ..rectangle = json['rectangle'] as String?;

Map<String, dynamic> _$IpGeoToJson(IpGeo instance) => <String, dynamic>{
      'statue': instance.statue,
      'info': instance.info,
      'infocode': instance.infocode,
      'province': instance.province,
      'city': instance.city,
      'adcode': instance.adcode,
      'rectangle': instance.rectangle,
    };
