import 'package:mercurius/index.dart';
part 'qweather.g.dart';

@JsonSerializable()
class QWeather {
  QWeather();

  String? code;
  String? updateTime;
  String? fxLink;
  QWeatherNow? now;
  QWeatherRefer? refer;

  factory QWeather.fromJson(Map<String, dynamic> json) =>
      _$QWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$QWeatherToJson(this);
}

@JsonSerializable()
class QWeatherNow {
  QWeatherNow({
    this.obsTime,
    this.temp,
    this.feelsLike,
    this.icon,
    this.text,
    this.wind360,
    this.windDir,
    this.windScale,
    this.windSpeed,
    this.humidity,
    this.precip,
    this.pressure,
    this.vis,
    this.cloud,
    this.dew,
  });

  String? obsTime;
  String? temp;
  String? feelsLike;
  String? icon;
  String? text;
  String? wind360;
  String? windDir;
  String? windScale;
  String? windSpeed;
  String? humidity;
  String? precip;
  String? pressure;
  String? vis;
  String? cloud;
  String? dew;

  factory QWeatherNow.fromJson(Map<String, dynamic> json) =>
      _$QWeatherNowFromJson(json);
  Map<String, dynamic> toJson() => _$QWeatherNowToJson(this);
}

@JsonSerializable()
class QWeatherRefer {
  QWeatherRefer();

  List<String>? sources;
  List<String>? license;

  factory QWeatherRefer.fromJson(Map<String, dynamic> json) =>
      _$QWeatherReferFromJson(json);
  Map<String, dynamic> toJson() => _$QWeatherReferToJson(this);
}
