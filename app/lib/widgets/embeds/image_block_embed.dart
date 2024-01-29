import 'package:mercurius/index.dart';

class ImageBlockEmbed extends Embeddable {
  const ImageBlockEmbed({
    required String filename,
  }) : super(imageType, filename);

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
    return _ImageBlock(
      controller: controller,
      node: node,
      readOnly: readOnly,
      inline: inline,
      textStyle: textStyle,
    );
  }
}

class _ImageBlock extends ConsumerWidget {
  const _ImageBlock({
    required this.controller,
    required this.node,
    required this.readOnly,
    required this.inline,
    required this.textStyle,
  });

  final QuillController controller;
  final Embed node;
  final bool readOnly;
  final bool inline;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: MouseRegion(
        cursor: readOnly ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: () {
            if (readOnly) {
              context.pushDialog(
                ImageView(filename: node.value.data as String),
              );
            }
          },
          child: Image(
            image: BasedLocalFirstImage(
              filename: node.value.data as String,
              localDirectory: paths.imageDirectory.path,
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
  }
}
