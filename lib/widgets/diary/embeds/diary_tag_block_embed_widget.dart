import 'package:mercurius/index.dart';

class DiaryTagBlockEmbed extends Embeddable {
  const DiaryTagBlockEmbed(
    String value,
  ) : super(mercuriusTagType, value);

  static const String mercuriusTagType = 'mercuriusTag';

  static DiaryTagBlockEmbed fromDocument(Document document) =>
      DiaryTagBlockEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class DiaryTagEmbedBuilderWidget extends EmbedBuilder {
  @override
  String get key => DiaryTagBlockEmbed.mercuriusTagType;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    DiaryTag tag = DiaryTag.fromJson(jsonDecode(node.value.data));

    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      avatar: Icon(
        IconData(
          tag.codePoint,
          fontFamily: tag.fontFamily,
          fontPackage: tag.fontPackage,
          matchTextDirection: tag.matchTextDirection,
        ),
      ),
      label: Text(tag.message),
    );
  }
}
