import 'package:mercurius/index.dart';

class DiaryPageViewWidget extends ConsumerStatefulWidget {
  const DiaryPageViewWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  ConsumerState<DiaryPageViewWidget> createState() =>
      _DiaryPageViewWidgetState();
}

class _DiaryPageViewWidgetState extends ConsumerState<DiaryPageViewWidget> {
  Widget _getPageBySnapshotData(AsyncSnapshot<List<Diary>> snapshot) {
    if (snapshot.data == null || snapshot.data!.isEmpty) {
      Navigator.pop(context);
    }

    List<Diary> diaries = snapshot.data!;

    /// FIXME: 问题见 https://github.com/flutter/flutter/issues/45632
    return PageView.builder(
      itemCount: diaries.length,
      controller: PageController(
        initialPage: diaries.indexWhere((e) => e.id == widget.diary.id),
      ),
      allowImplicitScrolling: true,
      itemBuilder: (context, index) => DiaryPageViewBodyWidget(
        key: UniqueKey(), // TIPS: 这里一定要是 `UniqueKey()`
        diary: diaries[index],
      ),
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
        return _getPageBySnapshotData(snapshot);
      case ConnectionState.done:
        return const Center(child: Text('Stream 已关闭'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Diary>>(
      stream: isarService
          .listenToDiariesContains(ref.watch(diarySearchTextProvider)),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Diary>> snapshot,
      ) =>
          _getBodyBySnapshotState(snapshot),
    );
  }
}
