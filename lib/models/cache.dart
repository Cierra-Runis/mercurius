import 'package:mercurius/index.dart';

part 'cache.g.dart';

@JsonSerializable()
class Cache {
  Cache();

  CachePosition? cachePosition;

  factory Cache.fromJson(Map<String, dynamic> json) => _$CacheFromJson(json);
  Map<String, dynamic> toJson() => _$CacheToJson(this);
}

@JsonSerializable()
class CachePosition {
  CachePosition();

  /// 纬度
  String latitude = '116.38';

  /// 经度
  String longitude = '39.91';

  /// 城市
  String city = '北京市';

  /// 缓存时间
  DateTime dateTime = DateTime.now();

  factory CachePosition.fromJson(Map<String, dynamic> json) =>
      _$CachePositionFromJson(json);
  Map<String, dynamic> toJson() => _$CachePositionToJson(this);
}
