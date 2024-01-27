import 'package:mercurius/index.dart';

class TagBlockEmbed extends Embeddable {
  const TagBlockEmbed({
    required Json json,
  }) : super(tagType, json);

  static const String tagType = 'mercuriusTag';
}

class TagBlockEmbedBuilder extends EmbedBuilder {
  const TagBlockEmbedBuilder();

  @override
  String get key => TagBlockEmbed.tagType;

  @override
  String toPlainText(Embed node) => DiaryTag.fromJson(node.value.data).message;

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
