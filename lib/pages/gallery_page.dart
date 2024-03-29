import 'package:mercurius/index.dart';

class GalleryPage extends ConsumerStatefulWidget {
  const GalleryPage({
    super.key,
    this.readOnly = false,
  });

  final bool readOnly;

  @override
  ConsumerState<GalleryPage> createState() => _MercuriusGalleryPageState();
}

class _MercuriusGalleryPageState extends ConsumerState<GalleryPage> {
  late bool _readOnly;
  late List<FileSystemEntity> _list = [];

  @override
  void initState() {
    super.initState();
    _readOnly = widget.readOnly;
  }

  int _sort(FileSystemEntity a, FileSystemEntity b) =>
      b.statSync().changed.differenceInSeconds(a.statSync().changed);

  Stream<List<FileSystemEntity>> listenToImageFile(String path) {
    return Stream.periodic(const Duration(milliseconds: 100), (_) {
      final newList = Directory('$path/image/').listSync();
      if (_list.length != newList.length) {
        newList.sort(_sort);
        return _list = newList;
      }
      return _list;
    });
  }

  Widget getGridBySnapshotData(
    BuildContext context,
    AsyncSnapshot<List<FileSystemEntity>> snapshot,
  ) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return Center(child: Text(l10n.noData));
    }

    final fileSystemEntities = snapshot.data!;

    return GridView.builder(
      cacheExtent: 1000,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.all(12.0),
      itemCount: fileSystemEntities.length,
      itemBuilder: (context, index) => GalleryCard(
        readOnly: _readOnly,
        fileSystemEntity: fileSystemEntities[index],
      ),
    );
  }

  Widget getBodyBySnapshotState(
    BuildContext context,
    AsyncSnapshot<List<FileSystemEntity>> snapshot,
  ) {
    if (snapshot.hasError) {
      return Center(child: Text('Steam error: ${snapshot.error}'));
    }
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const Center(child: Icon(UniconsLine.data_sharing));
      case ConnectionState.waiting:
        return const Loading();
      case ConnectionState.active:
        return getGridBySnapshotData(context, snapshot);
      case ConnectionState.done:
        return const Center(child: Text('Stream closed'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = ref.watch(mercuriusPathProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.imageGallery),
        actions: [
          if (_readOnly)
            TextButton(
              onPressed: () {
                settingsNotifier.setBgImgPath(null);
                context.pop();
              },
              child: Text(l10n.clear),
            ),
        ],
      ),
      body: path.when(
        loading: () => const Loading(),

        /// TODO: 这里应该提示 error
        error: (error, stackTrace) => const SizedBox(),
        data: (data) => StreamBuilder(
          stream: listenToImageFile(data).distinct(),
          builder: getBodyBySnapshotState,
        ),
      ),
    );
  }
}
