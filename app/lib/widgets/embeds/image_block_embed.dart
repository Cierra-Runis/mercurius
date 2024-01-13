import 'package:mercurius/index.dart';

class ImageBlockEmbed extends Embeddable {
  const ImageBlockEmbed(
    int diaryImageId,
  ) : super(mercuriusImageType, diaryImageId);

  static const String mercuriusImageType = 'mercuriusImage';
}

class ImageBlockEmbedBuilder extends EmbedBuilder {
  const ImageBlockEmbedBuilder();

  @override
  String get key => ImageBlockEmbed.mercuriusImageType;

  @override
  String toPlainText(Embed node) =>
      '[${ImageBlockEmbed.mercuriusImageType} ${node.value.data}]';

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
    final diaryImageId = node.value.data as int;

    Widget getInkWellChild(DiaryImage image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image(
          image: image.provider,
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
    }

    void onTap(DiaryImage image, bool readOnly) {
      if (readOnly) {
        context.pushDialog(
          ImageView(image: image),
        );
      }
    }

    return FutureBuilder<DiaryImage?>(
      future: isarService.getDiaryImageById(diaryImageId),
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
        if (snapshot.hasError) {
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
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
