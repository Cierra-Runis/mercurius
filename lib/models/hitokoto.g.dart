// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hitokoto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HiToKoToImpl _$$HiToKoToImplFromJson(Map<String, dynamic> json) =>
    _$HiToKoToImpl(
      id: json['id'] as int,
      uuid: json['uuid'] as String,
      hitokoto: json['hitokoto'] as String,
      type: json['type'] as String,
      from: json['from'] as String,
      fromWho: json['from_who'] as String,
      creator: json['creator'] as String,
      creatorUid: json['creator_uid'] as int,
      reviewer: json['reviewer'] as int,
      commitFrom: json['commit_from'] as String,
      createdAt: json['created_at'] as String,
      length: json['length'] as int,
    );

Map<String, dynamic> _$$HiToKoToImplToJson(_$HiToKoToImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'hitokoto': instance.hitokoto,
      'type': instance.type,
      'from': instance.from,
      'from_who': instance.fromWho,
      'creator': instance.creator,
      'creator_uid': instance.creatorUid,
      'reviewer': instance.reviewer,
      'commit_from': instance.commitFrom,
      'created_at': instance.createdAt,
      'length': instance.length,
    };
