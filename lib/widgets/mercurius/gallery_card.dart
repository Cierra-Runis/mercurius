import 'package:mercurius/index.dart';

class GalleryCard extends ConsumerWidget {
  const GalleryCard({
    super.key,
    required this.fileSystemEntity,
    this.readOnly = false,
  });

  final FileSystemEntity fileSystemEntity;
  final bool readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.current;
    final colorScheme = context.colorScheme;
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: readOnly
            ? () {
                settingsNotifier.setBgImgPath(
                  fileSystemEntity.path.split('/').last,
                );
                context.pop();
              }
            : () => context.pushDialog(
                  ImageView(
                    imageUrl: fileSystemEntity.path,
                  ),
                ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(fileSystemEntity.path),
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
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          fileSystemEntity.path.split('/').last,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: readOnly
                          ? null
                          : () async {
                              final confirm = await ConfirmDialog(
                                title: l10n.areYouSureToDeleteTheImage,
                                summary:
                                    l10n.pleaseThinkTwiceAboutDeletingTheImage,
                                context: context,
                              ).confirm;
                              if (confirm == true) {
                                fileSystemEntity.deleteSync();
                              }
                            },
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
