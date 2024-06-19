import 'package:mercurius/index.dart';

class ImageBlockEmbed extends Embeddable {
  const ImageBlockEmbed({
    required String filename,
  }) : super(_type, filename);

  static const _type = 'mercuriusImage';
}

class ImageBlockEmbedBuilder extends EmbedBuilder {
  const ImageBlockEmbedBuilder();

  @override
  String get key => ImageBlockEmbed._type;

  @override
  String toPlainText(Embed node) => '[$key]';

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
      child: Material(
        child: InkWell(
          onTap: readOnly
              ? () => context.pushDialog(
                    ImageView(filename: node.value.data as String),
                  )
              : null,
          child: Image(
            image: BasedLocalFirstImage(
              filename: node.value.data as String,
              localDirectory: paths.image.path,
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
                    fontSize: App.fontSize16,
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
