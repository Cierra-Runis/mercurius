import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'qweather_now.g.dart';

@riverpod
Future<QWeatherNow> qWeatherNow(
  QWeatherNowRef ref,
) async {
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
