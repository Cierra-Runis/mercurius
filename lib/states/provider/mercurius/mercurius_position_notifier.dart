import 'package:mercurius/index.dart';

class MercuriusPositionNotifier extends ChangeNotifier {
  CachePosition cachePosition = CachePosition();
  WeatherBody weatherBody = WeatherBody();

  /// 初始化
  void init() {
    MercuriusKit.printLog('mercuriusPositionNotifier 初始化中');
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

  /// 更新
  void update(bool force) async {
    await _getPosition(force);
    await _getQWeather();
    notifyListeners();
    super.notifyListeners();
  }

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

    List<dynamic> apiList = jsonDecode(
      await rootBundle.loadString('assets/json/api_key.json'),
    );

    Map<String, dynamic> api =
        apiList.firstWhere((element) => element['apiName'] == 'aMap');

    // 尝试连接 aMap 获取位置
    try {
      response = await Dio().get(
        api['apiUrl'],
        queryParameters: {
          'key': api['apiKey'],
          'output': 'json',
        },
      );
    } catch (e) {
      MercuriusKit.printLog('aMap 连接失败');
      return newCachePosition;
    }

    MercuriusKit.printLog('aMap 连接成功');

    dynamic data;
    if (response.statusCode == 200) {
      data = jsonDecode('$response');
      if (data['province'] == null ||
          data['city'] == null ||
          data['rectangle'] == null) {
        MercuriusKit.printLog('获取 aMap 失败');
        return newCachePosition;
      } else {
        MercuriusKit.printLog('获取 aMap 成功，且为 ${jsonEncode(data)}');
      }
    } else {
      MercuriusKit.printLog('获取 aMap 失败');
      return newCachePosition;
    }

    var match = RegExp(r'(.*),(.*);').firstMatch(data['rectangle']);

    newCachePosition = CachePosition()
      ..latitude = double.parse('${match![1]}').toStringAsFixed(2)
      ..longitude = double.parse('${match[2]}').toStringAsFixed(2)
      ..city = data['city']
      ..dateTime = DateTime.now();

    return newCachePosition;
  }

  /// 使用和风天气 api 获取天气
  Future<void> _getQWeather() async {
    Response response;

    List<dynamic> apiList = jsonDecode(
      await rootBundle.loadString('assets/json/api_key.json'),
    );

    Map<String, dynamic> api =
        apiList.firstWhere((element) => element['apiName'] == 'qWeather');

    weatherBody = WeatherBody.fromJson(jsonDecode(api['defaultJsonString']));

    // 尝试连接 qWeather 获取天气
    try {
      response = await Dio().get(
        api['apiUrl'],
        queryParameters: {
          'key': api['apiKey'],
          'location': '${cachePosition.latitude},${cachePosition.longitude}',
        },
      );
    } catch (e) {
      weatherBody.now!.icon = '2028';
      MercuriusKit.printLog('qWeather 连接失败');
      notifyListeners();
      super.notifyListeners();
      return;
    }

    MercuriusKit.printLog('qWeather 连接成功');

    if (response.statusCode == 200) {
      weatherBody = WeatherBody.fromJson(jsonDecode('$response'));
      MercuriusKit.printLog('获取 qWeather 成功，且为 ${jsonEncode(weatherBody)}');
    } else {
      weatherBody.now!.icon = '2028';
      MercuriusKit.printLog('获取 qWeather 失败');
      notifyListeners();
      super.notifyListeners();
      return;
    }

    notifyListeners();
    super.notifyListeners();
  }
}
