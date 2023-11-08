import 'package:mercurius/index.dart';

class ImageBlockEmbed extends Embeddable {
  const ImageBlockEmbed(
    String value,
  ) : super(mercuriusImageType, value);

  static const String mercuriusImageType = 'mercuriusImage';

  static ImageBlockEmbed fromDocument(Document document) =>
      ImageBlockEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class DeprecatedEmbed extends EmbedBuilder {
  @override
  String get key => 'deprecated';

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    return const Chip(
      label: Text('已弃用'),
    );
  }
}

class DiaryImageEmbedBuilderWidget extends EmbedBuilder {
  const DiaryImageEmbedBuilderWidget();

  @override
  String get key => ImageBlockEmbed.mercuriusImageType;

  @override
  String toPlainText(Embed node) => node.value.data;

  @override
  Widget build(
    BuildContext context,
    QuillController controller,
    Embed node,
    bool readOnly,
    bool inline,
    TextStyle textStyle,
  ) {
    final l10n = context.l10n;

    Widget getInkWellChild(File file) {
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.file(
            file,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return BasedShimmer(
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
        return BasedShimmer(
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
          builder: (context) => ImageViewWidget(
            imageUrl: file.path,
          ),
        );
      }
    }

    Future<File> getImageFile(String filename) async {
      Directory? directory;

      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else if (Platform.isWindows) {
        directory = await getApplicationSupportDirectory();
      } else {
        throw Exception('Unknown Platform');
      }
      return File('${directory!.path}/image/${node.value.data}');
    }

    return FutureBuilder<File>(
      future: getImageFile(node.value.data),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(16.0),
              onTap: () => onInkWellTap(snapshot.data!, readOnly),
              child: getInkWellChild(snapshot.data!),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
