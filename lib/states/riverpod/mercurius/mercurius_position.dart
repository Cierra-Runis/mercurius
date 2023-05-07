import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mercurius_position.g.dart';

@riverpod
class MercuriusPosition extends _$MercuriusPosition {
  @override
  Future<CachePosition> build() async {
    MercuriusKit.printLog('mercuriusPositionNotifier 初始化中');

    final profile = await ref.watch(mercuriusProfileProvider.future);
    CachePosition position;
    CachePosition? cachePosition = profile.cache.cachePosition;

    if (cachePosition != null) {
      int days = DateTime.now().difference(cachePosition.dateTime).inDays;
      position = days > 5 ? await _getAMap() : cachePosition;
    } else {
      position = await _getAMap();
    }

    return position;
  }

  void refreshPosition() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _getAMap());
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
}
