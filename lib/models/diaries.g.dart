// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diaries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diaries _$DiariesFromJson(Map<String, dynamic> json) => Diaries()
  ..diaries = (json['diaries'] as List<dynamic>?)
      ?.map((e) => Diaries.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DiariesToJson(Diaries instance) => <String, dynamic>{
      'diaries': instance.diaries?.map((e) => e.toJson()).toList(),
    };

Diary _$DiaryFromJson(Map<String, dynamic> json) => Diary()
  ..date = json['date'] as String?
  ..latestEditTime = json['latestEditTime'] as String?
  ..titleString = json['titleString'] as String?
  ..contentJsonString = json['contentJsonString'] as String?
  ..images =
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..weather = json['weather'] as String?
  ..mood = json['mood'] as String?;

Map<String, dynamic> _$DiaryToJson(Diary instance) => <String, dynamic>{
      'date': instance.date,
      'latestEditTime': instance.latestEditTime,
      'titleString': instance.titleString,
      'contentJsonString': instance.contentJsonString,
      'images': instance.images,
      'weather': instance.weather,
      'mood': instance.mood,
    };
