import 'package:mercurius/index.dart';

class GalleryPage extends ConsumerWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final paths = ref.watch(pathsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.imageGallery),
      ),
      body: Gallery(
        directory: paths.imageDirectory,
        onCardTap: (context, filename) => context.pushDialog(
          ImageView(filename: filename),
        ),
        actionsBuilder: (context, filename) => [
          IconButton(
            /// TODO: Confirm again
            onPressed: () => File(
              join(paths.imageDirectory.path, filename),
            ).delete(),
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
    );
  }
}
