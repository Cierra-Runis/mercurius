// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile()
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..token = json['token'] as String?
  ..themeMode = $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode'])
  ..cache = json['cache'] == null
      ? null
      : CacheConfig.fromJson(json['cache'] as Map<String, dynamic>)
  ..lastLogin = json['lastLogin'] as String?
  ..sudokuDifficulty = json['sudokuDifficulty'] as String?
  ..currentVersion = json['currentVersion'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode],
      'cache': instance.cache,
      'lastLogin': instance.lastLogin,
      'sudokuDifficulty': instance.sudokuDifficulty,
      'currentVersion': instance.currentVersion,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
