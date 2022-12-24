import 'package:mercurius/index.dart';

part 'diary.g.dart';

@collection
@JsonSerializable()
class Diary {
  Diary();

  /// 日记 `id`
  Id? id;

  /// 创建时间
  late DateTime createDateTime;

  /// 最后编辑时间
  late DateTime latestEditTime;

  /// 标题串
  String? titleString;

  /// 内容 json 串
  String? contentJsonString;

  /// 天气
  late String weather;

  /// 心情
  late String mood;

  /// 所使用的日记图片
  final diaryImages = IsarLinks<DiaryImage>();

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryToJson(this);
}
