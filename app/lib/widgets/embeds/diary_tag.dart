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

  TagBlockEmbeddable toEmbeddable() => TagBlockEmbeddable._(json: toJson());

  factory DiaryTag.fromJson(Json json) => _$DiaryTagFromJson(json);
}

class TagBlockEmbeddable extends Embeddable {
  const TagBlockEmbeddable._({
    required Json json,
  }) : super(tagType, json);

  static const tagType = 'mercuriusTag';
}

class TagBlockEmbedBuilder extends EmbedBuilder {
  const TagBlockEmbedBuilder();

  @override
  String get key => TagBlockEmbeddable.tagType;

  @override
  String toPlainText(Embed node) {
    final tag = DiaryTag.fromJson(node.value.data);
    return '[${tag.tagType} ${tag.message}]';
  }

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final tag = DiaryTag.fromJson(node.value.data);

    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      avatar: Icon(
        tag.tagType.iconData,
      ),
      label: Text(tag.message),
    );
  }
}
