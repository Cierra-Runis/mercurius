import 'package:mercurius/index.dart';

part 'weather_body.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherBody {
  WeatherBody();

  String? code;
  String? updateTime;
  String? fxLink;
  List<Daily>? daily;
  Refer? refer;

  factory WeatherBody.fromJson(Map<String, dynamic> json) =>
      _$WeatherBodyFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherBodyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Daily {
  Daily();

  DateTime? fxDate;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonPhaseIcon;
  String? tempMax;
  String? tempMin;
  String? iconDay;
  String? textDay;
  String? iconNight;
  String? textNight;
  String? wind360Day;
  String? windDirDay;
  String? windScaleDay;
  String? windSpeedDay;
  String? wind360Night;
  String? windDirNight;
  String? windScaleNight;
  String? windSpeedNight;
  String? humidity;
  String? precip;
  String? pressure;
  String? vis;
  String? cloud;
  String? uvIndex;

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);
  Map<String, dynamic> toJson() => _$DailyToJson(this);
}
