import 'package:mercurius/index.dart';

class MercuriusGalleryPage extends ConsumerWidget {
  const MercuriusGalleryPage({
    super.key,
    this.readOnly = false,
  });

  final bool readOnly;

  Stream<List<FileSystemEntity>> listenToImageFile(String path) {
    return Stream.periodic(
      const Duration(milliseconds: 100),
      (_) => Directory('$path/image/').listSync().where(
        (file) {
          return file.statSync().type == FileSystemEntityType.file;
        },
      ).toList(),
    );
  }

  Widget getGridBySnapshotData(
    BuildContext context,
    AsyncSnapshot<List<FileSystemEntity>> snapshot,
  ) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return Center(child: Text(l10n.noData));
    }

    List<FileSystemEntity> fileSystemEntities = snapshot.data!;

    return WaterfallFlow.builder(
      cacheExtent: 1000,
      gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.all(12.0),
      itemCount: fileSystemEntities.length,
      itemBuilder: (context, index) => MercuriusGalleryCardWidget(
        readOnly: readOnly,
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
        return const MercuriusLoadingWidget();
      case ConnectionState.active:
        return getGridBySnapshotData(context, snapshot);
      case ConnectionState.done:
        return const Center(child: Text('Stream closed'));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(mercuriusPathProvider);

    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.imageGallery),
      ),
      body: path.when(
        loading: () => const MercuriusLoadingWidget(),

        /// TODO: 这里应该提示 error
        error: (error, stackTrace) => Container(),
        data: (data) => StreamBuilder(
          stream: listenToImageFile(data).distinct(),
          builder: getBodyBySnapshotState,
        ),
      ),
    );
  }
}
