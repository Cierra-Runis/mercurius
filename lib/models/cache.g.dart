// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cache _$CacheFromJson(Map<String, dynamic> json) => Cache()
  ..cachePosition = json['cachePosition'] == null
      ? null
      : CachePosition.fromJson(json['cachePosition'] as Map<String, dynamic>);

Map<String, dynamic> _$CacheToJson(Cache instance) => <String, dynamic>{
      'cachePosition': instance.cachePosition,
    };

CachePosition _$CachePositionFromJson(Map<String, dynamic> json) =>
    CachePosition()
      ..latitude = json['latitude'] as String
      ..longitude = json['longitude'] as String
      ..city = json['city'] as String
      ..dateTime = DateTime.parse(json['dateTime'] as String);

Map<String, dynamic> _$CachePositionToJson(CachePosition instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'dateTime': instance.dateTime.toIso8601String(),
    };
