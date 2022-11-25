// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherBody _$WeatherBodyFromJson(Map<String, dynamic> json) => WeatherBody()
  ..code = json['code'] as String?
  ..updateTime = json['updateTime'] as String?
  ..fxLink = json['fxLink'] as String?
  ..daily = (json['daily'] as List<dynamic>?)
      ?.map((e) => Daily.fromJson(e as Map<String, dynamic>))
      .toList()
  ..refer = json['refer'] == null
      ? null
      : Refer.fromJson(json['refer'] as Map<String, dynamic>);

Map<String, dynamic> _$WeatherBodyToJson(WeatherBody instance) =>
    <String, dynamic>{
      'code': instance.code,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'daily': instance.daily?.map((e) => e.toJson()).toList(),
      'refer': instance.refer?.toJson(),
    };

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily()
  ..fxDate =
      json['fxDate'] == null ? null : DateTime.parse(json['fxDate'] as String)
  ..sunrise = json['sunrise'] as String?
  ..sunset = json['sunset'] as String?
  ..moonrise = json['moonrise'] as String?
  ..moonset = json['moonset'] as String?
  ..moonPhase = json['moonPhase'] as String?
  ..moonPhaseIcon = json['moonPhaseIcon'] as String?
  ..tempMax = json['tempMax'] as String?
  ..tempMin = json['tempMin'] as String?
  ..iconDay = json['iconDay'] as String?
  ..textDay = json['textDay'] as String?
  ..iconNight = json['iconNight'] as String?
  ..textNight = json['textNight'] as String?
  ..wind360Day = json['wind360Day'] as String?
  ..windDirDay = json['windDirDay'] as String?
  ..windScaleDay = json['windScaleDay'] as String?
  ..windSpeedDay = json['windSpeedDay'] as String?
  ..wind360Night = json['wind360Night'] as String?
  ..windDirNight = json['windDirNight'] as String?
  ..windScaleNight = json['windScaleNight'] as String?
  ..windSpeedNight = json['windSpeedNight'] as String?
  ..humidity = json['humidity'] as String?
  ..precip = json['precip'] as String?
  ..pressure = json['pressure'] as String?
  ..vis = json['vis'] as String?
  ..cloud = json['cloud'] as String?
  ..uvIndex = json['uvIndex'] as String?;

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
      'fxDate': instance.fxDate?.toIso8601String(),
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'moonPhase': instance.moonPhase,
      'moonPhaseIcon': instance.moonPhaseIcon,
      'tempMax': instance.tempMax,
      'tempMin': instance.tempMin,
      'iconDay': instance.iconDay,
      'textDay': instance.textDay,
      'iconNight': instance.iconNight,
      'textNight': instance.textNight,
      'wind360Day': instance.wind360Day,
      'windDirDay': instance.windDirDay,
      'windScaleDay': instance.windScaleDay,
      'windSpeedDay': instance.windSpeedDay,
      'wind360Night': instance.wind360Night,
      'windDirNight': instance.windDirNight,
      'windScaleNight': instance.windScaleNight,
      'windSpeedNight': instance.windSpeedNight,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'vis': instance.vis,
      'cloud': instance.cloud,
      'uvIndex': instance.uvIndex,
    };
