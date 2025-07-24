import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

typedef GalleryActionsBuilder = List<Widget> Function(
  BuildContext context,
  String filename,
);

typedef GalleryOnTap = void Function(
  BuildContext context,
  String filename,
);

class Gallery extends HookWidget {
  final Directory directory;

  final GalleryOnTap onCardTap;
  final GalleryActionsBuilder? actionsBuilder;
  const Gallery({
    super.key,
    required this.directory,
    required this.onCardTap,
    this.actionsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final stream = useMemoized(
      () => directory.watch().map((event) => directory.listSync()),
    );

    final snapshot = useStream(stream, initialData: directory.listSync());

    final files = snapshot.data;

    if (files == null || files.isEmpty) {
      return Center(
        child: Text(l10n.noData),
      );
    }

    return GridView.builder(
      cacheExtent: 1000,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
      ),
      padding: const EdgeInsets.all(12.0),
      itemCount: files.length,
      itemBuilder: (context, index) {
        final filename = p.basename(files[index].path);
        return FrameSeparateWidget(
          key: Key(filename),
          placeHolder: const Center(
            child: Loading(),
          ),
          child: _GalleryCard(
            filename: filename,
            onCardTap: onCardTap,
            actionsBuilder: actionsBuilder,
          ),
        );
      },
    );
  }
}

class _GalleryCard extends ConsumerWidget {
  final String filename;

  final void Function(BuildContext context, String filename)? onCardTap;
  final List<Widget> Function(BuildContext context, String filename)?
      actionsBuilder;
  const _GalleryCard({
    required this.filename,
    this.onCardTap,
    this.actionsBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);
    final colorScheme = context.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onCardTap != null ? () => onCardTap!(context, filename) : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: BasedLocalFirstImage(
                filename: filename,
                localDirectory: paths.image.path,
              ),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return BasedShimmer(
                  radius: 16,
                  width: double.maxFinite,
                  height: 100,
                  child: Text(
                    l10n.unsupportedImageFormat,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: App.fontSize8,
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ColoredBox(
                color: colorScheme.shadow.withAlpha(144),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actionsBuilder?.call(context, filename) ?? [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
