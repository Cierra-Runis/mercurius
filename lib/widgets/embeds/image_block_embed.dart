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

class ImageBlockEmbedBuilder extends EmbedBuilder {
  const ImageBlockEmbedBuilder();

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
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    Widget getInkWellChild(File file) {
      if (file.existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.file(
            file,
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

    void onTap(File file, bool readOnly) {
      if (file.existsSync() && readOnly) {
        context.pushDialog(
          ImageView(imageUrl: file.path),
        );
      }
    }

    Future<File> getImageFile(String filename) async {
      Directory? directory;

      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else if (Platform.isWindows || Platform.isIOS || Platform.isMacOS) {
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
          return MouseRegion(
            cursor: MaterialStateMouseCursor.clickable,
            child: GestureDetector(
              onTap: () => onTap(snapshot.data!, readOnly),
              child: getInkWellChild(snapshot.data!),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
