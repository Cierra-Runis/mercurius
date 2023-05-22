// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qweather_now.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QWeather _$QWeatherFromJson(Map<String, dynamic> json) => _QWeather()
  ..code = json['code'] as String?
  ..updateTime = json['updateTime'] as String?
  ..fxLink = json['fxLink'] as String?
  ..now = json['now'] == null
      ? null
      : QWeatherNow.fromJson(json['now'] as Map<String, dynamic>)
  ..refer = json['refer'] == null
      ? null
      : QWeatherRefer.fromJson(json['refer'] as Map<String, dynamic>);

Map<String, dynamic> _$QWeatherToJson(_QWeather instance) => <String, dynamic>{
      'code': instance.code,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'now': instance.now,
      'refer': instance.refer,
    };

QWeatherNow _$QWeatherNowFromJson(Map<String, dynamic> json) => QWeatherNow(
      obsTime: json['obsTime'] as String?,
      temp: json['temp'] as String?,
      feelsLike: json['feelsLike'] as String?,
      icon: json['icon'] as String?,
      text: json['text'] as String?,
      wind360: json['wind360'] as String?,
      windDir: json['windDir'] as String?,
      windScale: json['windScale'] as String?,
      windSpeed: json['windSpeed'] as String?,
      humidity: json['humidity'] as String?,
      precip: json['precip'] as String?,
      pressure: json['pressure'] as String?,
      vis: json['vis'] as String?,
      cloud: json['cloud'] as String?,
      dew: json['dew'] as String?,
    );

Map<String, dynamic> _$QWeatherNowToJson(QWeatherNow instance) =>
    <String, dynamic>{
      'obsTime': instance.obsTime,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'icon': instance.icon,
      'text': instance.text,
      'wind360': instance.wind360,
      'windDir': instance.windDir,
      'windScale': instance.windScale,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'vis': instance.vis,
      'cloud': instance.cloud,
      'dew': instance.dew,
    };

QWeatherRefer _$QWeatherReferFromJson(Map<String, dynamic> json) =>
    QWeatherRefer()
      ..sources =
          (json['sources'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..license =
          (json['license'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$QWeatherReferToJson(QWeatherRefer instance) =>
    <String, dynamic>{
      'sources': instance.sources,
      'license': instance.license,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$qWeatherNowHash() => r'3ea3cc4e71bd3b259d5f6c0beafb38e2fa72291c';

/// See also [qWeatherNow].
@ProviderFor(qWeatherNow)
final qWeatherNowProvider = AutoDisposeFutureProvider<QWeatherNow>.internal(
  qWeatherNow,
  name: r'qWeatherNowProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$qWeatherNowHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QWeatherNowRef = AutoDisposeFutureProviderRef<QWeatherNow>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
