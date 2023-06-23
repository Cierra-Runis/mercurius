import 'package:mercurius/index.dart';
part 'diary.g.dart';

@collection
@JsonSerializable()
class Diary {
  const Diary({
    required this.id,
    required this.createDateTime,
    required this.latestEditTime,
    required this.contentJsonString,
    this.editing = false,
    this.titleString = '',
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
  final String titleString;

  /// 内容 json 串
  final String contentJsonString;

  /// 标记日记是否为 `editing` 状态
  /// 是则在 `createNewDiary` 浮动按钮处红点提示并不再显示 list card 和 page view
  /// 否则按一般情况处理
  final bool editing;

  /// 枚举类型 [DiaryWeatherType]
  @enumerated
  final DiaryWeatherType weatherType;

  /// 枚举类型 [DiaryMoodType]
  @enumerated
  final DiaryMoodType moodType;

  @ignore
  Document get document => Document.fromJson(jsonDecode(contentJsonString));

  @ignore
  String get plainText => document.toPlainText().replaceAll(RegExp(r'\n'), '');

  @ignore
  int get words => plainText.length;

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
    bool? editing,
    DiaryWeatherType? weatherType,
    DiaryMoodType? moodType,
  }) =>
      Diary(
        id: id ?? diary.id,
        createDateTime: createDateTime ?? diary.createDateTime,
        latestEditTime: latestEditTime ?? diary.latestEditTime,
        titleString: titleString ?? diary.titleString,
        contentJsonString: contentJsonString ?? diary.contentJsonString,
        editing: editing ?? diary.editing,
        weatherType: weatherType ?? diary.weatherType,
        moodType: moodType ?? diary.moodType,
      );
}
