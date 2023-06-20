import 'package:mercurius/index.dart';

/// 枚举类型 [DiaryMoodType]
enum DiaryMoodType {
  defaultType('smile', UniconsLine.smile),
  angry('angry', UniconsLine.angry),
  confused('confused', UniconsLine.confused),
  frown('frown', UniconsLine.frown),
  laughing('laughing', UniconsLine.laughing),
  silentSquint('silentSquint', UniconsLine.silent_squint),
  sadCrying('sadCrying', UniconsLine.sad_crying),
  smileDizzy('smileDizzy', UniconsLine.smile_dizzy),
  mehClosedEye('normal', UniconsLine.meh_closed_eye);

  const DiaryMoodType(this.mood, this.iconData);
  final String mood;
  final IconData iconData;
}

/// 枚举类型 [DiaryWeatherType]
enum DiaryWeatherType {
  defaultType('sunny', QWeatherIcons.tag_sunny),
  cloudy('cloudy', QWeatherIcons.tag_cloudy),
  fewClouds('fewClouds', QWeatherIcons.tag_few_clouds),
  heavyThunderstorm('heavyThunderstorm', QWeatherIcons.tag_heavy_thunderstorm),
  lightRain('lightRain', QWeatherIcons.tag_light_rain),
  heavyRain('heavyRain', QWeatherIcons.tag_heavy_rain),
  lightSnow('lightSnow', QWeatherIcons.tag_light_snow),
  heavySnow('heavySnow', QWeatherIcons.tag_heavy_snow),
  foggy('foggy', QWeatherIcons.tag_foggy);

  const DiaryWeatherType(this.weather, this.qweatherIcons);
  final String weather;
  final QWeatherIcons qweatherIcons;
}
