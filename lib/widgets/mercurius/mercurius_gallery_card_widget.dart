import 'package:mercurius/index.dart';

class MercuriusGalleryCardWidget extends StatelessWidget {
  const MercuriusGalleryCardWidget({
    super.key,
    required this.fileSystemEntity,
    this.readOnly = false,
  });

  final FileSystemEntity fileSystemEntity;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: readOnly
            ? () {
                Navigator.of(context).pop(fileSystemEntity.path);
              }
            : () async => await showDialog(
                  context: context,
                  builder: (context) => DiaryImageViewWidget(
                    imageUrl: fileSystemEntity.path,
                  ),
                ),
        child: Column(
          children: [
            Image.file(
              File(fileSystemEntity.path),
              errorBuilder: (context, error, stackTrace) {
                return MercuriusFadeShimmerWidget(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      fileSystemEntity.path.split('/').last,
                      style: const TextStyle(fontSize: 10.0),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: readOnly
                      ? null
                      : () async {
                          bool? confirm = await MercuriusConfirmDialogWidget(
                            title: l10n.areYouSureToDeleteTheImage,
                            summary: l10n.pleaseThinkTwiceAboutDeletingTheImage,
                            context: context,
                          ).confirm;
                          if (confirm == true) {
                            fileSystemEntity.deleteSync();
                          }
                        },
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
