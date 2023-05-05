import 'package:mercurius/index.dart';

class MercuriusGalleryPage extends StatefulWidget {
  const MercuriusGalleryPage({Key? key}) : super(key: key);

  @override
  State<MercuriusGalleryPage> createState() => _MercuriusGalleryPageState();
}

class _MercuriusGalleryPageState extends State<MercuriusGalleryPage> {
  Stream<List<FileSystemEntity>> listenToImageFile() {
    return Stream.periodic(
      const Duration(milliseconds: 100),
      (_) => Directory('${mercuriusPathNotifier.path}/image/').listSync(),
    );
  }

  Widget getGridBySnapshotData(AsyncSnapshot<List<FileSystemEntity>> snapshot) {
    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(child: Text('无数据'));
    }

    List<FileSystemEntity> fileSystemEntity = snapshot.data!;

    return WaterfallFlow.builder(
      gridDelegate: const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.all(12.0),
      itemCount: fileSystemEntity.length,
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async => await showDialog(
            context: context,
            builder: (context) => DiaryImageViewWidget(
              imageUrl: fileSystemEntity[index].path,
            ),
          ),
          child: Column(
            children: [
              Image.file(
                File(fileSystemEntity[index].path),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        fileSystemEntity[index].path.split('/').last,
                        style: const TextStyle(fontSize: 10.0),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      bool? confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) =>
                            const MercuriusOriginalConfirmDialogWidget(),
                      );
                      if (confirm == true) {
                        fileSystemEntity[index].deleteSync();
                      }
                    },
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 12,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getBodyBySnapshotState(
      AsyncSnapshot<List<FileSystemEntity>> snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('Steam 错误: ${snapshot.error}'));
    }
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const Center(child: Icon(UniconsLine.data_sharing));
      case ConnectionState.waiting:
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.staggeredDotsWave(
                color: Theme.of(context).colorScheme.primary,
                size: 16,
              ),
              const SizedBox(width: 20),
              const Text('读取中'),
            ],
          ),
        );
      case ConnectionState.active:
        return getGridBySnapshotData(snapshot);
      case ConnectionState.done:
        return const Center(child: Text('Stream 已关闭'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('图片库'),
      ),
      body: StreamBuilder(
        stream: listenToImageFile().distinct(),
        builder: (context, snapshot) => getBodyBySnapshotState(snapshot),
      ),
    );
  }
}
