
import 'package:mercurius/index.dart';

class DiaryImageBlockEmbed extends BlockEmbed {
  const DiaryImageBlockEmbed(
    String value,
  ) : super(mercuriusImageType, value);

  static const String mercuriusImageType = 'mercuriusImage';

  static DiaryImageBlockEmbed fromDocument(Document document) =>
      DiaryImageBlockEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class DiaryImageEmbedBuilderWidget extends EmbedBuilder {
  @override
  String get key => 'mercuriusImage';

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
  ) {
    String imageUrl = node.value.data;
    File file = File(imageUrl);

    Widget image = file.existsSync()
        ? Image.file(file, alignment: Alignment.center)
        : const Placeholder(
            child: Center(
              heightFactor: 12,
              child: Text('图片缺失'),
            ),
          );

    return Material(
      child: InkWell(
        onTap: readOnly
            ? () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => DiaryPageViewImageWidget(
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              }
            : null,
        child: image,
      ),
    );
  }
}
