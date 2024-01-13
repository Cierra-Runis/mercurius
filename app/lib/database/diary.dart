import '../../app/lib/index.dart';
part 'diary.g.dart';

@collection
@JsonSerializable()
class Diary {
  const Diary({
    required this.id,
    required this.createDateTime,
    required this.latestEditTime,
    required this.content,
    this.editing = false,
    this.title = '',
    this.moodType = DiaryMoodType.defaultType,
    this.weatherType = DiaryWeatherType.defaultType,
  });

  final int id;

  final DateTime createDateTime;

  final DateTime latestEditTime;

  final String title;

  final List<dynamic> content;

  final bool editing;

  @enumValue
  final DiaryWeatherType weatherType;

  @enumValue
  final DiaryMoodType moodType;

  @ignore
  Document get document => Document.fromJson(content);

  @ignore
  String get plainText => document.toPlainText().replaceAll(RegExp(r'\n'), '');

  @ignore
  int get words => plainText.length;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryToJson(this);

  Diary copyWith({
    int? id,
    DateTime? createDateTime,
    DateTime? latestEditTime,
    String? title,
    List<dynamic>? content,
    bool? editing,
    DiaryWeatherType? weatherType,
    DiaryMoodType? moodType,
  }) =>
      Diary(
        id: id ?? this.id,
        createDateTime: createDateTime ?? this.createDateTime,
        latestEditTime: latestEditTime ?? this.latestEditTime,
        title: title ?? this.title,
        content: content ?? this.content,
        editing: editing ?? this.editing,
        weatherType: weatherType ?? this.weatherType,
        moodType: moodType ?? this.moodType,
      );
}
