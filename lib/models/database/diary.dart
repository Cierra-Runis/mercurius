import 'package:mercurius/index.dart';

part 'diary.g.dart';

@collection
@JsonSerializable()
class Diary {
  const Diary({
    this.id,
    required this.createDateTime,
    required this.latestEditTime,
    this.titleString,
    this.contentJsonString,
    this.mood = '一般',
    this.weather = '100',
  });

  /// 日记 `id`
  final Id? id;

  /// 创建时间
  final DateTime createDateTime;

  /// 最后编辑时间
  final DateTime latestEditTime;

  /// 标题串
  final String? titleString;

  /// 内容 json 串
  final String? contentJsonString;

  /// 天气
  final String weather;

  /// 心情
  final String mood;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryToJson(this);

  /// 转换用工厂函数
  factory Diary.copyFrom(
    Diary diary, {
    Id? id,
    DateTime? createDateTime,
    DateTime? latestEditTime,
    String? titleString,
    String? contentJsonString,
    String? weather,
    String? mood,
  }) =>
      Diary(
        id: id ?? diary.id,
        createDateTime: createDateTime ?? diary.createDateTime,
        latestEditTime: latestEditTime ?? diary.latestEditTime,
        titleString: titleString ?? diary.titleString,
        contentJsonString: contentJsonString ?? diary.contentJsonString,
        weather: weather ?? diary.weather,
        mood: mood ?? diary.mood,
      );
}
