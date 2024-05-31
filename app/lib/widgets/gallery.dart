import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

typedef GalleryOnTap = void Function(
  BuildContext context,
  String filename,
);

typedef GalleryActionsBuilder = List<Widget> Function(
  BuildContext context,
  String filename,
);

class Gallery extends HookWidget {
  const Gallery({
    super.key,
    required this.directory,
    required this.onCardTap,
    this.actionsBuilder,
  });

  final Directory directory;
  final GalleryOnTap onCardTap;
  final GalleryActionsBuilder? actionsBuilder;

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
          placeHolder: const Center(
            child: Loading(),
          ),
          child: _GalleryCard(
            key: Key(filename),
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
  const _GalleryCard({
    super.key,
    required this.filename,
    this.onCardTap,
    this.actionsBuilder,
  });

  final String filename;
  final void Function(BuildContext context, String filename)? onCardTap;
  final List<Widget> Function(BuildContext context, String filename)?
      actionsBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);
    final colorScheme = context.colorScheme;

    return Card(
      child: InkWell(
        onTap: onCardTap != null ? () => onCardTap!(context, filename) : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: BasedLocalFirstImage(
                filename: filename,
                localDirectory: paths.imageDirectory.path,
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
                      fontSize: 8.0,
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
