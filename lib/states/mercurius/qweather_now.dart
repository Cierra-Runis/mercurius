import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'qweather_now.g.dart';

@riverpod
Future<QWeatherNow> qWeatherNow(
  QWeatherNowRef ref,
) async {
  ref.keepAlive();

  CachePosition cachePosition =
      await ref.watch(mercuriusPositionProvider.future);

  String apiName = MercuriusApi.qWeather.apiName;
  String apiUrl = MercuriusApi.qWeather.apiUrl;
  String aqiKey = MercuriusApi.qWeather.apiKey;

  MercuriusKit.printLog('$apiName 初始化中');

  QWeather qWeather = QWeather();
  QWeatherNow qWeatherNow = QWeatherNow();

  Response response;
  try {
    response = await Dio().get(
      apiUrl,
      queryParameters: {
        'key': aqiKey,
        'location': '${cachePosition.latitude},${cachePosition.longitude}',
      },
    );
  } catch (e) {
    MercuriusKit.printLog('$apiName 连接失败');
    return qWeatherNow;
  }

  MercuriusKit.printLog('$apiName 连接成功');

  if (response.statusCode == 200) {
    MercuriusKit.printLog('$apiName 请求成功 $response');
    qWeather = QWeather.fromJson(
      jsonDecode('$response'),
    );
  } else {
    MercuriusKit.printLog('$apiName 请求失败');
  }

  return qWeather.now ?? qWeatherNow;
}

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
