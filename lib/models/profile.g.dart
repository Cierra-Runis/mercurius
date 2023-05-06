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
  ..buttonVibration = json['buttonVibration'] as bool?
  ..lastLogin = json['lastLogin'] as String?
  ..sudokuDifficultyType = $enumDecodeNullable(
      _$SudokuDifficultyTypeEnumMap, json['sudokuDifficultyType'])
  ..currentVersion = json['currentVersion'] as String?
  ..cache = Cache.fromJson(json['cache'] as Map<String, dynamic>);

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode],
      'buttonVibration': instance.buttonVibration,
      'lastLogin': instance.lastLogin,
      'sudokuDifficultyType':
          _$SudokuDifficultyTypeEnumMap[instance.sudokuDifficultyType],
      'currentVersion': instance.currentVersion,
      'cache': instance.cache,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$SudokuDifficultyTypeEnumMap = {
  SudokuDifficultyType.easy: 'easy',
  SudokuDifficultyType.normal: 'normal',
  SudokuDifficultyType.insane: 'insane',
  SudokuDifficultyType.defaultType: 'defaultType',
};
