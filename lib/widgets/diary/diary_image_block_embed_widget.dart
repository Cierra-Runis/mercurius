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
    Widget getInkWellChild(File file) {
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.file(file, alignment: Alignment.center),
        );
      } else {
        return SizedBox(
          height: 200,
          child: Placeholder(
            strokeWidth: 0.5,
            color: Theme.of(context).colorScheme.error,
            child: Center(
              child: Text(
                '位于\n${file.path}\n的图片缺失}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 8.0,
                ),
              ),
            ),
          ),
        );
      }
    }

    void onInkWellTap(File file, bool readOnly) {
      if (file.existsSync() && readOnly) {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => DiaryPageViewImageWidget(
              imageUrl: file.path,
            ),
          ),
        );
      }
    }

    File file = File(node.value.data);

    return Material(
      child: InkWell(
        onTap: () => onInkWellTap(file, readOnly),
        child: getInkWellChild(file),
      ),
    );
  }
}
