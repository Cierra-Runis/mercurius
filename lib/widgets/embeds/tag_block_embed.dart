import 'package:mercurius/index.dart';

class TagBlockEmbed extends Embeddable {
  const TagBlockEmbed(
    String value,
  ) : super(mercuriusTagType, value);

  static const String mercuriusTagType = 'mercuriusTag';
}

class TagBlockEmbedBuilder extends EmbedBuilder {
  const TagBlockEmbedBuilder();

  @override
  String get key => TagBlockEmbed.mercuriusTagType;

  @override
  String toPlainText(Embed node) =>
      DiaryTag.fromJson(jsonDecode(node.value.data)).message;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final tag = DiaryTag.fromJson(jsonDecode(node.value.data));

    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      avatar: Icon(
        tag.tagType.iconData,
      ),
      label: Text(tag.message),
    );
  }
}
