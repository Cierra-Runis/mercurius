// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..user = User.fromJson(json['user'] as Map<String, dynamic>)
  ..token = json['token'] as String?
  ..themeMode = json['themeMode'] as ThemeMode?
  ..cache = json['cache'] == null
      ? null
      : CacheConfig.fromJson(json['cache'] as Map<String, dynamic>)
  ..lastLogin = json['lastLogin'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'themeMode': instance.themeMode,
      'cache': instance.cache,
      'lastLogin': instance.lastLogin,
    };
