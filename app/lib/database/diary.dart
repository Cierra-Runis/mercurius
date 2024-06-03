import 'package:mercurius/index.dart';

part 'diary.freezed.dart';
part 'diary.g.dart';

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
    DiaryMoodType? moodType,
    DiaryWeatherType? weatherType,
  }) = _Diary;

  @ignore
  Document get document => Document.fromJson(content);

  @ignore
  String get plainText => document.plainText;

  @ignore
  int get length => plainText.length;

  factory Diary.fromJson(Json json) => _$DiaryFromJson(json);
}
