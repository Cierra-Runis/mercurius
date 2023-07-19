import 'package:mercurius/index.dart';

class DiaryImageViewWidget extends ConsumerWidget {
  const DiaryImageViewWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Center(
          child: PhotoView(
            enableRotation: true,
            backgroundDecoration: const BoxDecoration(),
            tightMode: true,
            imageProvider: FileImage(File(imageUrl)),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CloseButton(
            onPressed: () {
              Mercurius.vibration(ref: ref);
              Navigator.of(context).pop();
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(imageUrl.split('/').last),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () async {
              Mercurius.vibration(ref: ref);
              Mercurius.printLog(imageUrl);
              await Share.shareFiles([imageUrl]);
            },
            icon: const Icon(Icons.file_download_rounded),
          ),
        ),
      ],
    );
  }
}
