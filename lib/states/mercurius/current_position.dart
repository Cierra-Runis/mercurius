import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_position.g.dart';

/// 使用高德 api 获取位置
@riverpod
Future<CurrentPosition> currentPosition(CurrentPositionRef ref) async {
  ref.keepAlive();
  Response response;
  CurrentPosition newCachePosition = CurrentPosition();

  // 尝试连接 aMap 获取位置
  try {
    response = await Dio().get(
      MercuriusApi.aMap.apiUrl,
      queryParameters: {
        'key': MercuriusApi.aMap.apiKey,
        'output': 'json',
      },
    );
  } catch (e) {
    Mercurius.printLog('aMap 连接失败');
    return newCachePosition;
  }

  Mercurius.printLog('aMap 连接成功');

  dynamic data;
  if (response.statusCode == 200) {
    data = jsonDecode('$response');
    if (data['province'] == null ||
        data['city'] == null ||
        data['rectangle'] == null) {
      Mercurius.printLog('获取 aMap 失败');
      return newCachePosition;
    } else {
      Mercurius.printLog('获取 aMap 成功，且为 ${jsonEncode(data)}');
    }
  } else {
    Mercurius.printLog('获取 aMap 失败');
    return newCachePosition;
  }

  var match = RegExp(r'(.*),(.*);').firstMatch(data['rectangle']);

  newCachePosition = CurrentPosition()
    ..latitude = double.parse('${match![1]}').toStringAsFixed(2)
    ..longitude = double.parse('${match[2]}').toStringAsFixed(2)
    ..city = data['city']
    ..dateTime = DateTime.now();

  return newCachePosition;
}

@JsonSerializable()
class CurrentPosition {
  CurrentPosition();

  /// 纬度
  String latitude = '116.38';

  /// 经度
  String longitude = '39.91';

  /// 城市
  String city = '北京市';

  /// 缓存时间
  DateTime dateTime = DateTime.now();

  /// 获得格式化字符串
  String get humanFormat => '${latitude}N ${longitude}E';

  factory CurrentPosition.fromJson(Map<String, dynamic> json) =>
      _$CurrentPositionFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentPositionToJson(this);
}
