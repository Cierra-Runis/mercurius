import 'package:mercurius/index.dart';

class DiaryListViewWidget extends StatefulWidget {
  const DiaryListViewWidget({super.key});

  @override
  State<DiaryListViewWidget> createState() => _DiaryListViewWidgetState();
}

class _DiaryListViewWidgetState extends State<DiaryListViewWidget> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget _getCardBySnapshotData(AsyncSnapshot<List<Diary>> snapshot) =>
      snapshot.data == null || snapshot.data!.isEmpty
          ? const Center(child: Text('无数据'))
          : ListView.builder(
              itemCount: snapshot.data!.length,
              itemExtent: 100,
              cacheExtent: 800,
              shrinkWrap: true,
              itemBuilder: (context, index) => FrameSeparateWidget(
                index: index,
                placeHolder: DiaryListViewCardWidget(context: context),
                child: DiaryListViewCardWidget(
                  diary: snapshot.data![index],
                  key: UniqueKey(), // TIPS: 这里一定要是 `UniqueKey()`
                  context: context,
                ),
              ),
            );

  Widget _getBodyBySnapshotState(AsyncSnapshot<List<Diary>> snapshot) {
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
        return SmartRefresher(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500), () {});
            diarySearchTextNotifier.changeContains(
              diarySearchTextNotifier.contains,
            );
            _refreshController.refreshCompleted();
          },
          controller: _refreshController,
          child: _getCardBySnapshotData(snapshot),
        );
      case ConnectionState.done:
        return const Center(child: Text('Stream 已关闭'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiarySearchTextNotifier>(
      builder: (context, diarySearchTextNotifier, child) {
        return StreamBuilder<List<Diary>>(
          stream: isarService
              .listenToDiariesContains(diarySearchTextNotifier.contains),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Diary>> snapshot,
          ) =>
              _getBodyBySnapshotState(snapshot),
        );
      },
    );
  }
}
