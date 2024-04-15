import 'package:mercurius/index.dart';

part 'diary_tag.freezed.dart';
part 'diary_tag.g.dart';

@freezed
class DiaryTag with _$DiaryTag {
  const DiaryTag._();

  const factory DiaryTag({
    required DiaryTagType tagType,
    required String message,
  }) = _DiaryTag;

  Embeddable toEmbeddable() => _TagBlockEmbeddable(json: toJson());

  factory DiaryTag.fromJson(Json json) => _$DiaryTagFromJson(json);
}

class _TagBlockEmbeddable extends Embeddable {
  const _TagBlockEmbeddable({
    required Json json,
  }) : super(_type, json);

  static const _type = 'mercuriusTag';
}

class TagBlockEmbedBuilder extends EmbedBuilder {
  const TagBlockEmbedBuilder();

  @override
  String get key => _TagBlockEmbeddable._type;

  @override
  String toPlainText(Embed node) {
    final tag = DiaryTag.fromJson(node.value.data);
    return '[${tag.message}]';
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
