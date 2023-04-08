import 'package:mercurius/index.dart';

String _aMapUrl =
    'https://restapi.amap.com/v3/ip?&output=json&key=${ApiKeyConstance.aMapKey}';

String _qWeatherUrl =
    'https://devapi.qweather.com/v7/weather/now?&key=${ApiKeyConstance.qWeatherKey}';

String _qWeatherDefaultJsonString =
    '{"code":"200","updateTime":"2023-01-15T00:02+08:00","fxLink":"http://hfx.link/1tjp1","now":{"obsTime":"2023-01-14T23:56+08:00","temp":"-7","feelsLike":"-15","icon":"1031","text":"晴","wind360":"31","windDir":"东北风","windScale":"2","windSpeed":"7","humidity":"26","precip":"0.0","pressure":"1032","vis":"30","cloud":"10","dew":"-25"},"refer":{"sources":["QWeather","NMC","ECMWF"],"license":["CC BY-SA 4.0"]}}';

class MercuriusPositionNotifier extends ChangeNotifier {
  CachePosition cachePosition = CachePosition();
  WeatherBody weatherBody = WeatherBody();

  /// 获取当前位置
  Future<void> _getPosition(bool force) async {
    if (mercuriusProfileNotifier.profile.cache.cachePosition != null &&
        !force) {
      cachePosition = mercuriusProfileNotifier.profile.cache.cachePosition!;
    } else {
      Cache newCache = mercuriusProfileNotifier.profile.cache;
      cachePosition = await _getAMap();
      mercuriusProfileNotifier.changeProfile(
        mercuriusProfileNotifier.profile
          ..cache = (newCache..cachePosition = cachePosition),
      );
    }
    notifyListeners();
    super.notifyListeners();
  }

  /// 使用高德 api 获取位置
  Future<CachePosition> _getAMap() async {
    Response response;
    CachePosition newCachePosition = CachePosition();

    // 尝试连接 aMap 获取位置
    try {
      response = await Dio().get(_aMapUrl);
    } catch (e) {
      DevTools.printLog('aMap 连接失败');
      return newCachePosition;
    }

    DevTools.printLog('aMap 连接成功');

    dynamic data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.toString());
      if (data['province'] == null ||
          data['city'] == null ||
          data['rectangle'] == null) {
        DevTools.printLog('获取 aMap 失败');
        return newCachePosition;
      } else {
        DevTools.printLog('获取 aMap 成功，且为 ${jsonEncode(data)}');
      }
    } else {
      DevTools.printLog('获取 aMap 失败');
      return newCachePosition;
    }

    var match = RegExp(r'(.*),(.*);').firstMatch(data['rectangle']);

    newCachePosition = CachePosition()
      ..latitude = double.parse(match![1].toString()).toStringAsFixed(2)
      ..longitude = double.parse(match[2].toString()).toStringAsFixed(2)
      ..city = data['city']
      ..dateTime = DateTime.now();

    return newCachePosition;
  }

  /// 使用和风天气 api 获取天气
  Future<void> _getQWeather() async {
    Response response;

    weatherBody = WeatherBody.fromJson(jsonDecode(_qWeatherDefaultJsonString));

    // 尝试连接 qWeather 获取天气
    try {
      response = await Dio().get(
        '$_qWeatherUrl&location=${cachePosition.latitude},${cachePosition.longitude}',
      );
    } catch (e) {
      weatherBody.now!.icon = '2028';
      DevTools.printLog('qWeather 连接失败');
      notifyListeners();
      super.notifyListeners();
      return;
    }

    DevTools.printLog('qWeather 连接成功');

    if (response.statusCode == 200) {
      weatherBody = WeatherBody.fromJson(jsonDecode(response.toString()));
      DevTools.printLog('获取 qWeather 成功，且为 ${jsonEncode(weatherBody)}');
    } else {
      weatherBody.now!.icon = '2028';
      DevTools.printLog('获取 qWeather 失败');
      notifyListeners();
      super.notifyListeners();
      return;
    }

    notifyListeners();
    super.notifyListeners();
  }

  /// 更新
  void update(bool force) {
    _getPosition(force).then((value) => _getQWeather());
    notifyListeners();
    super.notifyListeners();
  }

  void init() {
    DevTools.printLog('mercuriusPositionNotifier 初始化中');
    CachePosition? cachePosition =
        mercuriusProfileNotifier.profile.cache.cachePosition;
    if (cachePosition != null) {
      Duration duration = DateTime.now().difference(cachePosition.dateTime);
      update(duration.inDays > 5);
    } else {
      update(false);
    }
    notifyListeners();
    super.notifyListeners();
  }
}
