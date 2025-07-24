import 'package:mercurius/index.dart';

part 'diary.freezed.dart';
part 'diary.g.dart';

@freezed
class Diary with _$Diary {
  const factory Diary({
    required DateTime belongTo,
    required DateTime createAt,
    required DateTime editAt,
    required List<dynamic> content,
    @Default(false) bool editing,
    DiaryMoodType? moodType,
    DiaryWeatherType? weatherType,
  }) = _Diary;

  factory Diary.fromJson(Json json) => _$DiaryFromJson(json);

  const Diary._();

  @ignore
  Document get document => Document.fromJson(content);

  @ignore
  int get length => plainText.length;

  @ignore
  String get plainText => document.plainText;
}
