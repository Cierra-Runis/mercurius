import 'package:mercurius/index.dart';

/// 枚举类型 [DiaryMoodType]
enum DiaryMoodType {
  defaultType('开心', UniconsLine.smile),
  angry('生气', UniconsLine.angry),
  confused('困惑', UniconsLine.confused),
  frown('失落', UniconsLine.frown),
  laughing('大笑', UniconsLine.laughing),
  silentSquint('难过', UniconsLine.silent_squint),
  sadCrying('大哭', UniconsLine.sad_crying),
  smileDizzy('我死', UniconsLine.smile_dizzy),
  mehClosedEye('一般', UniconsLine.meh_closed_eye);

  const DiaryMoodType(this.mood, this.iconData);
  final String mood;
  final IconData iconData;

  static IconData getIconDataByMood(String? mood) => DiaryMoodType.values
      .firstWhereOrDefault(
        (element) => element.mood == mood,
        defaultValue: DiaryMoodType.defaultType,
      )
      .iconData;
}

/// 枚举类型 [DiaryWeatherType]
enum DiaryWeatherType {
  defaultType('晴', '100', QWeatherIcon.tag_sunny),
  cloudy('多云', '101', QWeatherIcon.tag_cloudy),
  fewClouds('阴', '102', QWeatherIcon.tag_few_clouds),
  heavyThunderstorm('雷暴', '303', QWeatherIcon.tag_heavy_thunderstorm),
  lightRain('小雨', '305', QWeatherIcon.tag_light_rain),
  heavyRain('大雨', '307', QWeatherIcon.tag_heavy_rain),
  lightSnow('小雪', '400', QWeatherIcon.tag_light_snow),
  heavySnow('大雪', '402', QWeatherIcon.tag_heavy_snow),
  foggy('雾', '501', QWeatherIcon.tag_foggy);

  const DiaryWeatherType(this.weather, this.id, this.iconData);
  final String weather;
  final String id;
  final IconData iconData;

  static String getWeatherById(String? id) => DiaryWeatherType.values
      .firstWhereOrDefault(
        (element) => element.id == id,
        defaultValue: DiaryWeatherType.defaultType,
      )
      .weather;
}

/// 枚举类型 [SudokuDifficultyType]
enum SudokuDifficultyType {
  easy('简单', 18, Icons.child_friendly_rounded),
  normal('普通', 27, Icons.child_care_rounded),
  insane('疯狂', 36, Icons.school_rounded),
  defaultType('专家', 54, Icons.biotech_rounded);

  const SudokuDifficultyType(this.difficulty, this.emptySquares, this.iconData);
  final String difficulty;
  final int emptySquares;
  final IconData iconData;
}

extension ListExtension<T> on List<T> {
  T firstWhereOrDefault(
    bool Function(T element) condition, {
    required T defaultValue,
  }) {
    for (final element in this) {
      if (condition(element)) return element;
    }
    return defaultValue;
  }
}
