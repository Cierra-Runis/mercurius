import 'package:mercurius/index.dart';

part 'diary.g.dart';

@collection
@JsonSerializable()
class Diary {
  Diary();
  Id? id;

  late String createDateTime;
  late String latestEditTime;
  String? titleString;
  String? contentJsonString;
  late String weather;
  late String mood;

  final diaryImages = IsarLinks<DiaryImage>();

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryToJson(this);
}
