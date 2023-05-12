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
}

/// 枚举类型 [DiaryWeatherType]
enum DiaryWeatherType {
  defaultType('晴', QWeatherIcons.tag_sunny),
  cloudy('多云', QWeatherIcons.tag_cloudy),
  fewClouds('阴', QWeatherIcons.tag_few_clouds),
  heavyThunderstorm('雷暴', QWeatherIcons.tag_heavy_thunderstorm),
  lightRain('小雨', QWeatherIcons.tag_light_rain),
  heavyRain('大雨', QWeatherIcons.tag_heavy_rain),
  lightSnow('小雪', QWeatherIcons.tag_light_snow),
  heavySnow('大雪', QWeatherIcons.tag_heavy_snow),
  foggy('雾', QWeatherIcons.tag_foggy);

  const DiaryWeatherType(this.weather, this.qweatherIcons);
  final String weather;
  final QWeatherIcons qweatherIcons;
}
