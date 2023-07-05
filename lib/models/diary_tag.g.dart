// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiaryTag _$DiaryTagFromJson(Map<String, dynamic> json) => DiaryTag(
      codePoint: json['codePoint'] as int,
      message: json['message'] as String,
      fontFamily: json['fontFamily'] as String?,
      fontPackage: json['fontPackage'] as String?,
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
    );

Map<String, dynamic> _$DiaryTagToJson(DiaryTag instance) => <String, dynamic>{
      'codePoint': instance.codePoint,
      'fontFamily': instance.fontFamily,
      'fontPackage': instance.fontPackage,
      'matchTextDirection': instance.matchTextDirection,
      'message': instance.message,
    };
