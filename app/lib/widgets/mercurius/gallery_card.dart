import 'package:mercurius/index.dart';

class GalleryCard extends ConsumerWidget {
  const GalleryCard({
    super.key,
    required this.diaryImage,
    this.readOnly = false,
    required this.onTap,
  });

  final DiaryImage diaryImage;
  final bool readOnly;
  final void Function(BuildContext context, DiaryImage diaryImage) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;
    final colorScheme = context.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: !readOnly ? () => onTap(context, diaryImage) : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: diaryImage.provider,
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
                          diaryImage.title,
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
                                isarService.deleteDiaryImageById(diaryImage.id);
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
