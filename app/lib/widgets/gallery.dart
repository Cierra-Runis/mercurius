import 'package:mercurius/index.dart';
import 'package:path/path.dart' as path;

typedef GalleryOnTap = void Function(
  BuildContext context,
  String filename,
);

typedef GalleryActionsBuilder = List<Widget> Function(
  BuildContext context,
  String filename,
);

class Gallery extends ConsumerStatefulWidget {
  const Gallery({
    super.key,
    required this.onCardTap,
    this.actionsBuilder,
  });

  final GalleryOnTap onCardTap;
  final GalleryActionsBuilder? actionsBuilder;

  @override
  ConsumerState<Gallery> createState() => _GalleryPageState();
}

class _GalleryPageState extends ConsumerState<Gallery> {
  late List<FileSystemEntity> _files;

  @override
  Widget build(BuildContext context) {
    final paths = ref.watch(pathsProvider);
    final directory = Directory(paths.imageDirectory);
    _files = directory.listSync();
    directory.watch().listen(
          (event) => setState(() => _files = directory.listSync()),
        );

    return GridView.builder(
      cacheExtent: 1000,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
      ),
      padding: const EdgeInsets.all(12.0),
      itemCount: _files.length,
      itemBuilder: (context, index) {
        final filename = path.basename(_files[index].path);
        return _GalleryCard(
          key: Key(filename),
          filename: filename,
          onCardTap: widget.onCardTap,
          actionsBuilder: widget.actionsBuilder,
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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onCardTap != null ? () => onCardTap!(context, filename) : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: BasedLocalFirstImage(
                filename: filename,
                localDirectory: paths.imageDirectory,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: actionsBuilder?.call(context, filename) ?? [],
                  // children: [
                  //   IconButton(
                  //     onPressed: readOnly
                  //         ? null
                  //         : () async {
                  //             final confirm = await ConfirmDialog(
                  //               title: l10n.areYouSureToDeleteTheImage,
                  //               summary:
                  //                   l10n.pleaseThinkTwiceAboutDeletingTheImage,
                  //               context: context,
                  //             ).confirm;
                  //             if (confirm ?? false) {
                  //               isarService.deleteDiaryImageById(diaryImage.id);
                  //             }
                  //           },
                  //     icon: const Icon(
                  //       Icons.delete_outline_rounded,
                  //     ),
                  //   ),
                  // ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
