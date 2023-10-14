import 'package:mercurius/index.dart';

class ImageViewWidget extends ConsumerWidget {
  const ImageViewWidget({
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
            onPressed: context.pop,
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
            onPressed: () => Share.shareFiles([imageUrl]),
            icon: const Icon(Icons.file_download_rounded),
          ),
        ),
      ],
    );
  }
}
