// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sentence _$SentenceFromJson(Map<String, dynamic> json) => Sentence()
  ..id = json['id'] as num?
  ..context = json['context'] as String?
  ..owner = json['owner'] == null
      ? null
      : User.fromJson(json['owner'] as Map<String, dynamic>)
  ..createdAt = json['createdAt'] as String?;

Map<String, dynamic> _$SentenceToJson(Sentence instance) => <String, dynamic>{
      'id': instance.id,
      'context': instance.context,
      'owner': instance.owner,
      'createdAt': instance.createdAt,
    };
