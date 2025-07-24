import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.imageGallery),
      ),
      body: _LocalGallery(),
    );
  }
}

class _LocalGallery extends ConsumerWidget {
  const _LocalGallery();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageDirectory = ref.watch(
      pathsProvider.select((value) => value.image),
    );

    return Gallery(
      directory: imageDirectory,
      onCardTap: (context, filename) => context.pushDialog(
        ImageView(filename: filename),
      ),
      actionsBuilder: (context, filename) => [
        IconButton(
          /// TODO: Confirm again
          onPressed: () => File(
            p.join(imageDirectory.path, filename),
          ).delete(),
          icon: const Icon(Icons.delete_rounded),
        ),
      ],
    );
  }
}
