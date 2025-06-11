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
    EmbedContext embedContext,
  ) {
    return _ImageBlock(
      embedContext: embedContext,
    );
  }
}

class _ImageBlock extends ConsumerWidget {
  const _ImageBlock({
    required this.embedContext,
  });

  final EmbedContext embedContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);
    final filename = embedContext.node.value.data as String;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Material(
        child: InkWell(
          onTap: embedContext.readOnly
              ? () => context.pushDialog(
                    ImageView(filename: filename),
                  )
              : null,
          child: Image(
            image: BasedLocalFirstImage(
              filename: filename,
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
