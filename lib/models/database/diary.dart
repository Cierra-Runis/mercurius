import 'package:mercurius/index.dart';

part 'diary.g.dart';

@collection
@JsonSerializable()
class Diary {
  const Diary({
    required this.id,
    required this.createDateTime,
    required this.latestEditTime,
    this.titleString,
    this.contentJsonString,
    this.moodType = DiaryMoodType.defaultType,
    this.weatherType = DiaryWeatherType.defaultType,
  });

  /// 日记 `id`
  final Id id;

  /// 创建时间
  final DateTime createDateTime;

  /// 最后编辑时间
  final DateTime latestEditTime;

  /// 标题串
  final String? titleString;

  /// 内容 json 串
  final String? contentJsonString;

  /// 枚举类型 [DiaryWeatherType]
  @enumerated
  final DiaryWeatherType weatherType;

  /// 枚举类型 [DiaryMoodType]
  @enumerated
  final DiaryMoodType moodType;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryToJson(this);

  /// 转换用工厂函数
  factory Diary.copyWith(
    Diary diary, {
    Id? id,
    DateTime? createDateTime,
    DateTime? latestEditTime,
    String? titleString,
    String? contentJsonString,
    DiaryWeatherType? weatherType,
    DiaryMoodType? moodType,
  }) =>
      Diary(
        id: id ?? diary.id,
        createDateTime: createDateTime ?? diary.createDateTime,
        latestEditTime: latestEditTime ?? diary.latestEditTime,
        titleString: titleString ?? diary.titleString,
        contentJsonString: contentJsonString ?? diary.contentJsonString,
        weatherType: weatherType ?? diary.weatherType,
        moodType: moodType ?? diary.moodType,
      );
}
