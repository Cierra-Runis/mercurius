import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

class ImageView extends ConsumerWidget {
  const ImageView({
    super.key,
    required this.filename,
  });

  final String filename;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paths = ref.watch(pathsProvider);

    return SafeArea(
      child: Stack(
        children: [
          Center(
            child: PhotoView(
              enableRotation: true,
              backgroundDecoration: const BoxDecoration(),
              tightMode: true,
              imageProvider: BasedLocalFirstImage(
                filename: filename,
                localDirectory: paths.image.path,
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
              onPressed: () => App.shareXFiles([
                XFile(p.join(paths.image.path, filename)),
              ]),
              icon: const Icon(UniconsLine.share),
            ),
          ),
        ],
      ),
    );
  }
}
