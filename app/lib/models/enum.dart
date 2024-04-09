import 'package:mercurius/index.dart';

/// [DiaryMoodType]
enum DiaryMoodType {
  smile('smile', UniconsLine.smile),
  angry('angry', UniconsLine.angry),
  confused('confused', UniconsLine.confused),
  frown('frown', UniconsLine.frown),
  laughing('laughing', UniconsLine.laughing),
  silentSquint('silentSquint', UniconsLine.silent_squint),
  sadCrying('sadCrying', UniconsLine.sad_crying),
  smileDizzy('smileDizzy', UniconsLine.smile_dizzy),
  mehClosedEye('normal', UniconsLine.meh_closed_eye);

  const DiaryMoodType(this.mood, this.iconData);
  @enumValue
  final String mood;
  final IconData iconData;
}

/// [DiaryWeatherType]
enum DiaryWeatherType {
  sunny('sunny', QWeatherIcons.tag_sunny),
  cloudy('cloudy', QWeatherIcons.tag_cloudy),
  fewClouds('fewClouds', QWeatherIcons.tag_few_clouds),
  heavyThunderstorm('heavyThunderstorm', QWeatherIcons.tag_heavy_thunderstorm),
  lightRain('lightRain', QWeatherIcons.tag_light_rain),
  heavyRain('heavyRain', QWeatherIcons.tag_heavy_rain),
  lightSnow('lightSnow', QWeatherIcons.tag_light_snow),
  heavySnow('heavySnow', QWeatherIcons.tag_heavy_snow),
  foggy('foggy', QWeatherIcons.tag_foggy);

  const DiaryWeatherType(this.weather, this.qweatherIcons);

  @enumValue
  final String weather;
  final QWeatherIcons qweatherIcons;
}

enum DiaryTagType {
  accessTime(Icons.access_time_rounded),
  accessTimeFilled(Icons.access_time_filled_rounded),
  accessAlarm(Icons.access_alarm_rounded),
  accountBalanceWallet(Icons.account_balance_wallet_rounded),
  adUnits(Icons.ad_units_rounded),
  assignment(Icons.assignment_outlined),
  attractions(Icons.attractions_rounded),
  audiotrack(Icons.audiotrack_rounded),
  autoAwesome(Icons.auto_awesome_rounded),
  badge(Icons.badge_rounded),
  balance(Icons.balance_rounded),
  bathtub(Icons.bathtub_rounded),
  beachAccess(Icons.beach_access_rounded),
  bed(Icons.bed_rounded);

  const DiaryTagType(this.iconData);
  final IconData iconData;
}
