import 'package:mercurius/index.dart';
part 'diary_tag.g.dart';
part 'diary_tag.freezed.dart';

@freezed
class DiaryTag with _$DiaryTag {
  const DiaryTag._();

  const factory DiaryTag({
    required DiaryTagType tagType,
    required String message,
  }) = _DiaryTag;

  factory DiaryTag.fromJson(Json json) => _$DiaryTagFromJson(json);
}
