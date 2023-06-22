import 'package:mercurius/index.dart';

class DiaryImageBlockEmbed extends Embeddable {
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
    TextStyle textStyle,
  ) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    Widget getInkWellChild(File file) {
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.file(
            file,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return MercuriusFadeShimmerWidget(
                radius: 16,
                width: double.maxFinite,
                height: 200,
                child: Text(
                  l10n.unsupportedImageFormat,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return MercuriusFadeShimmerWidget(
          radius: 16,
          width: double.maxFinite,
          height: 200,
          child: Text(
            l10n.imageMissing,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        );
      }
    }

    void onInkWellTap(File file, bool readOnly) {
      if (file.existsSync() && readOnly) {
        showDialog(
          context: context,
          builder: (context) => DiaryImageViewWidget(
            imageUrl: file.path,
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
