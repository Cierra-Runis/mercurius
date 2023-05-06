import 'package:mercurius/index.dart';

class MercuriusOriginalGalleryCardWidget extends StatelessWidget {
  const MercuriusOriginalGalleryCardWidget({
    super.key,
    required this.fileSystemEntity,
    this.readOnly = false,
  });

  final FileSystemEntity fileSystemEntity;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
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
                return const MercuriusModifiedFadeShimmerWidget(
                  radius: 16,
                  width: double.maxFinite,
                  height: 100,
                  child: Text(
                    '错误的图片格式\n请重新插入',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                          bool? confirm =
                              await MercuriusOriginalConfirmDialogWidget(
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
