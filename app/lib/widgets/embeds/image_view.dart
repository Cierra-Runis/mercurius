import 'package:mercurius/index.dart';

class ImageView extends ConsumerWidget {
  const ImageView({
    super.key,
    required this.fileName,
  });

  final String fileName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paths = ref.watch(pathsProvider);

    return Stack(
      children: [
        Center(
          child: PhotoView(
            enableRotation: true,
            backgroundDecoration: const BoxDecoration(),
            tightMode: true,
            imageProvider: BasedLocalFirstImage(
              fileName: fileName,
              localDirectory: paths.imageDirectory,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CloseButton(
            onPressed: context.pop,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            onPressed: () => Share.shareXFiles([
              XFile(join(paths.imageDirectory, fileName)),
            ]),
            icon: const Icon(UniconsLine.share),
          ),
        ),
      ],
    );
  }
}
