import 'package:mercurius/index.dart';

class ImageView extends ConsumerWidget {
  const ImageView({
    super.key,
    required this.filename,
  });

  final String filename;

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
              filename: filename,
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
              XFile(join(paths.imageDirectory, filename)),
            ]),
            icon: const Icon(UniconsLine.share),
          ),
        ),
      ],
    );
  }
}
