import 'package:mercurius/index.dart';

part 'diary_tag.freezed.dart';
part 'diary_tag.g.dart';

@freezed
class DiaryTag with _$DiaryTag {
  const factory DiaryTag({
    required DiaryTagType tagType,
    required String message,
  }) = _DiaryTag;

  factory DiaryTag.fromJson(Json json) => _$DiaryTagFromJson(json);

  const DiaryTag._();

  Embeddable toEmbeddable() => _TagBlockEmbeddable(json: toJson());
}

class TagBlockEmbedBuilder extends EmbedBuilder {
  const TagBlockEmbedBuilder();

  @override
  String get key => _TagBlockEmbeddable._type;

  @override
  Widget build(
    BuildContext context,
    EmbedContext embedContext,
  ) {
    final node = embedContext.node;
    final tag = DiaryTag.fromJson(node.value.data);

    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      avatar: Icon(
        tag.tagType.iconData,
      ),
      label: Text(tag.message),
    );
  }

  @override
  String toPlainText(Embed node) {
    final tag = DiaryTag.fromJson(node.value.data);
    return '[${tag.message}]';
  }
}

class _TagBlockEmbeddable extends Embeddable {
  static const _type = 'mercuriusTag';

  const _TagBlockEmbeddable({
    required Json json,
  }) : super(_type, json);
}
