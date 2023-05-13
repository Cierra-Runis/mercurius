import 'package:mercurius/index.dart';

class MercuriusGalleryPage extends ConsumerWidget {
  const MercuriusGalleryPage({
    Key? key,
    this.readOnly = false,
  }) : super(key: key);

  final bool readOnly;

  Stream<List<FileSystemEntity>> listenToImageFile(String path) {
    /// TIPS: 这里只排除了文件夹，而未排除所有 `Image` 不支持的文件
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
    AsyncSnapshot<List<FileSystemEntity>> snapshot,
  ) {
    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(child: Text('无数据'));
    }

    List<FileSystemEntity> fileSystemEntities = snapshot.data!;

    return WaterfallFlow.builder(
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
    AsyncSnapshot<List<FileSystemEntity>> snapshot,
  ) {
    if (snapshot.hasError) {
      return Center(child: Text('Steam 错误: ${snapshot.error}'));
    }
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const Center(child: Icon(UniconsLine.data_sharing));
      case ConnectionState.waiting:
        return const MercuriusLoadingWidget();
      case ConnectionState.active:
        return getGridBySnapshotData(snapshot);
      case ConnectionState.done:
        return const Center(child: Text('Stream 已关闭'));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(mercuriusPathProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('图片库'),
      ),
      body: path.when(
        loading: () => const MercuriusLoadingWidget(),

        /// TODO: 这里应该提示错误
        error: (error, stackTrace) => Container(),
        data: (data) => StreamBuilder(
          stream: listenToImageFile(data).distinct(),
          builder: (context, snapshot) => getBodyBySnapshotState(snapshot),
        ),
      ),
    );
  }
}
