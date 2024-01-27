import 'package:mercurius/index.dart';
part 'diary.g.dart';
part 'diary.freezed.dart';

@collection
@freezed
class Diary with _$Diary {
  const Diary._();

  const factory Diary({
    required int id,
    required DateTime createAt,
    required DateTime editAt,
    required List<Json> content,
    @Default(false) bool editing,
    @Default('') String title,
    @Default(DiaryMoodType.defaultType) DiaryMoodType moodType,
    @Default(DiaryWeatherType.defaultType) DiaryWeatherType weatherType,
  }) = _Diary;

  @ignore
  Document get document => Document.fromJson(content);

  @ignore
  String get plainText => document.toPlainText().replaceAll(RegExp(r'\n'), '');

  @ignore
  int get words => plainText.length;

  factory Diary.fromJson(Json json) => _$DiaryFromJson(json);
}
