import 'package:mercurius/index.dart';

class DiaryPageViewWidget extends StatefulWidget {
  const DiaryPageViewWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryPageViewWidget> createState() => _DiaryPageViewWidgetState();
}

class _DiaryPageViewWidgetState extends State<DiaryPageViewWidget> {
  Widget _getCardBySnapshotData(AsyncSnapshot<List<Diary>> snapshot) {
    List<Diary> diaries = snapshot.data!;

    return PageView(
      controller: PageController(
        initialPage:
            diaries.indexWhere((element) => element.id == widget.diary.id),
      ),
      children: [
        for (Diary diary in diaries) DiaryPageViewBodyWidget(diary: diary),
      ],
    );
  }

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
        return _getCardBySnapshotData(snapshot);
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
