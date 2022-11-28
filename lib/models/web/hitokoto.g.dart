// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hitokoto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HiToKoTo _$HiToKoToFromJson(Map<String, dynamic> json) => HiToKoTo()
  ..id = json['id'] as int?
  ..uuid = json['uuid'] as String?
  ..hitokoto = json['hitokoto'] as String
  ..type = json['type'] as String?
  ..from = json['from'] as String?
  ..from_who = json['from_who'] as String?
  ..creator = json['creator'] as String?
  ..creator_uid = json['creator_uid'] as int?
  ..reviewer = json['reviewer'] as int?
  ..commit_from = json['commit_from'] as String?
  ..created_at = json['created_at'] as String?
  ..length = json['length'] as int?;

Map<String, dynamic> _$HiToKoToToJson(HiToKoTo instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'hitokoto': instance.hitokoto,
      'type': instance.type,
      'from': instance.from,
      'from_who': instance.from_who,
      'creator': instance.creator,
      'creator_uid': instance.creator_uid,
      'reviewer': instance.reviewer,
      'commit_from': instance.commit_from,
      'created_at': instance.created_at,
      'length': instance.length,
    };
