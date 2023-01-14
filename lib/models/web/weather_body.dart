import 'package:mercurius/index.dart';

part 'weather_body.g.dart';

@JsonSerializable()
class WeatherBody {
  WeatherBody();

  String? code;
  String? updateTime;
  String? fxLink;
  Now? now;
  Refer? refer;

  factory WeatherBody.fromJson(Map<String, dynamic> json) =>
      _$WeatherBodyFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherBodyToJson(this);
}

@JsonSerializable()
class Now {
  Now({
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

  factory Now.fromJson(Map<String, dynamic> json) => _$NowFromJson(json);
  Map<String, dynamic> toJson() => _$NowToJson(this);
}

@JsonSerializable()
class Refer {
  Refer();

  List<String>? sources;
  List<String>? license;

  factory Refer.fromJson(Map<String, dynamic> json) => _$ReferFromJson(json);
  Map<String, dynamic> toJson() => _$ReferToJson(this);
}
