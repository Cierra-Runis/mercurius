import 'package:mercurius/index.dart';

class ImageBlockEmbed extends Embeddable {
  const ImageBlockEmbed({
    required String fileName,
  }) : super(imageType, fileName);

  static const String imageType = 'mercuriusImage';
}

class ImageBlockEmbedBuilder extends EmbedBuilder {
  const ImageBlockEmbedBuilder();

  @override
  String get key => ImageBlockEmbed.imageType;

  @override
  String toPlainText(Embed node) =>
      '[${ImageBlockEmbed.imageType} ${node.value.data}]';

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

    return Consumer(
      builder: (context, ref, child) {
        return MouseRegion(
          cursor: MaterialStateMouseCursor.clickable,
          child: GestureDetector(
            onTap: () {
              if (readOnly) {
                context.pushDialog(
                  ImageView(fileName: node.value.data as String),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image(
                image: BasedLocalFirstImage(
                  fileName: node.value.data as String,
                  localDirectory: ref.watch(pathsProvider).imageDirectory,
                ),
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
            ),
          ),
        );
      },
    );
  }
}
