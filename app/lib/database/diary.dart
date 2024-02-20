import 'package:mercurius/index.dart';
part 'diary.g.dart';
part 'diary.freezed.dart';

@collection
@freezed
class Diary with _$Diary {
  const Diary._();

  const factory Diary({
    required int id,
    required DateTime belongTo,
    required DateTime createAt,
    required DateTime editAt,
    required List<dynamic> content,
    @Default(false) bool editing,
    @Default('') String title,
    @Default(DiaryMoodType.defaultType) DiaryMoodType moodType,
    @Default(DiaryWeatherType.defaultType) DiaryWeatherType weatherType,
  }) = _Diary;

  @ignore
  Document get document => Document.fromJson(content);

  @ignore
  String get plainText => document.toPlainText(
        EditorBody.embedBuilders,
        EditorBody.unknownEmbedBuilder,
      );

  @ignore
  int get words => plainText.length;

  factory Diary.fromJson(Json json) => _$DiaryFromJson(json);
}
