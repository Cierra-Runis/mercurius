import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

class GalleryPage extends StatelessWidget {
  static const tabViews = [
    _LocalGallery(key: PageStorageKey(_LocalGallery)),
    _GitHubGallery(key: PageStorageKey(_GitHubGallery)),
  ];

  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DefaultTabController(
      length: tabViews.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.imageGallery),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Local'),
              Tab(text: 'GitHub'),
            ],
          ),
        ),
        body: const TabBarView(children: tabViews),
      ),
    );
  }
}

class _GitHubGallery extends ConsumerWidget {
  const _GitHubGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final autoUploadImages = ref.watch(
      settingsProvider.select((value) => value.autoBackupDiaries),
    );
    return Center(
      child: autoUploadImages ? const Text('Enabled') : const Text('Disabled'),
    );
  }
}

class _LocalGallery extends ConsumerWidget {
  const _LocalGallery({super.key});

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
