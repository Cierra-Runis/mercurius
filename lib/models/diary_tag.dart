import 'package:mercurius/index.dart';

part 'diary_tag.g.dart';

@JsonSerializable()
class DiaryTag {
  const DiaryTag({
    required this.codePoint,
    required this.message,
    this.fontFamily,
    this.fontPackage,
    this.matchTextDirection = false,
  });
  final int codePoint;
  final String? fontFamily;
  final String? fontPackage;
  final bool matchTextDirection;
  final String message;

  factory DiaryTag.fromJson(Map<String, dynamic> json) =>
      _$DiaryTagFromJson(json);
  Map<String, dynamic> toJson() => _$DiaryTagToJson(this);
}
