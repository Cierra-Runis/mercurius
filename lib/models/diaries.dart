import 'package:mercurius/index.dart';

part 'diaries.g.dart';

@JsonSerializable(explicitToJson: true)
class Diaries {
  Diaries();

  List<Diaries>? diaries;

  factory Diaries.fromJson(Map<String, dynamic> json) =>
      _$DiariesFromJson(json);
  Map<String, dynamic> toJson() => _$DiariesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Diary {
  Diary();

  String? date;
  String? latestEditTime;
  String? titleString;
  String? contentJsonString;
  List<String>? images;
  String? weather;
  String? mood;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryToJson(this);
}
