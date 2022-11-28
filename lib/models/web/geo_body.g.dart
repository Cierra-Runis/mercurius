// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoBody _$GeoBodyFromJson(Map<String, dynamic> json) => GeoBody()
  ..code = json['code'] as String?
  ..location = (json['location'] as List<dynamic>?)
      ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
      .toList()
  ..refer = json['refer'] == null
      ? null
      : Refer.fromJson(json['refer'] as Map<String, dynamic>);

Map<String, dynamic> _$GeoBodyToJson(GeoBody instance) => <String, dynamic>{
      'code': instance.code,
      'location': instance.location?.map((e) => e.toJson()).toList(),
      'refer': instance.refer?.toJson(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location()
  ..name = json['name'] as String?
  ..id = json['id'] as String?
  ..lat = json['lat'] as String?
  ..lon = json['lon'] as String?
  ..adm2 = json['adm2'] as String?
  ..adm1 = json['adm1'] as String?
  ..country = json['country'] as String?
  ..tz = json['tz'] as String?
  ..utcOffset = json['utcOffset'] as String?
  ..isDst = json['isDst'] as String?
  ..type = json['type'] as String?
  ..rank = json['rank'] as String?
  ..fxLink = json['fxLink'] as String?;

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'lat': instance.lat,
      'lon': instance.lon,
      'adm2': instance.adm2,
      'adm1': instance.adm1,
      'country': instance.country,
      'tz': instance.tz,
      'utcOffset': instance.utcOffset,
      'isDst': instance.isDst,
      'type': instance.type,
      'rank': instance.rank,
      'fxLink': instance.fxLink,
    };

Refer _$ReferFromJson(Map<String, dynamic> json) => Refer()
  ..sources =
      (json['sources'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..license =
      (json['license'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$ReferToJson(Refer instance) => <String, dynamic>{
      'sources': instance.sources,
      'license': instance.license,
    };
