import 'package:mercurius/index.dart';

class DiaryListViewWidget extends ConsumerStatefulWidget {
  const DiaryListViewWidget({super.key});
  @override
  ConsumerState<DiaryListViewWidget> createState() =>
      _DiaryListViewWidgetState();
}

class _DiaryListViewWidgetState extends ConsumerState<DiaryListViewWidget> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget _getCardBySnapshotData(AsyncSnapshot<List<Diary>> snapshot) {
    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(child: Text('无数据'));
    }

    List<_DiaryListViewSection> sections = [];
    List<Diary> diaries = snapshot.data!;

    int year = diaries[0].createDateTime.year;
    int month = diaries[0].createDateTime.month;
    sections.add(_DiaryListViewSection()..header = '$year年$month月');

    for (Diary diary in diaries) {
      if (diary.createDateTime.month == month &&
          diary.createDateTime.year == year) {
        sections.last.items.add(diary);
      } else {
        month = diary.createDateTime.month;
        year = diary.createDateTime.year;
        sections.add(
          _DiaryListViewSection()
            ..header = '$year年$month月'
            ..items.add(diary),
        );
      }
    }

    return ExpandableListView(
      cacheExtent: 1000,
      builder: SliverExpandableChildDelegate<Diary, _DiaryListViewSection>(
        sectionList: sections,
        headerBuilder: (context, sectionIndex, index) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: MercuriusListItemWidget(
              iconData: Icons.directions_subway,
              titleText: sections[sectionIndex].header,
              accessoryView: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  '共 ${sections[sectionIndex].items.length} 篇',
                ),
              ),
              disabled: true,
            ),
          );
        },
        itemBuilder: (context, sectionIndex, itemIndex, index) {
          return FrameSeparateWidget(
            index: index,
            placeHolder: DiaryListViewCardPlaceHolderWidget(
              key: UniqueKey(), // TIPS: 这里一定要是 `UniqueKey()`
            ),
            child: DiaryListViewCardWidget(
              key: UniqueKey(), // TIPS: 这里一定要是 `UniqueKey()`
              diary: sections[sectionIndex].items[itemIndex],
            ),
          );
        },
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
        return const MercuriusLoadingWidget();
      case ConnectionState.active:
        return SmartRefresher(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            ref.watch(diarySearchTextProvider.notifier).change();
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
    return StreamBuilder<List<Diary>>(
      stream: ref
          .watch(isarServiceProvider.notifier)
          .listenToDiariesContains(ref.watch(diarySearchTextProvider)),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Diary>> snapshot,
      ) =>
          _getBodyBySnapshotState(snapshot),
    );
  }
}

class _DiaryListViewSection implements ExpandableListSection<Diary> {
  late String header;
  List<Diary> items = [];

  @override
  List<Diary> getItems() => items;

  @override
  bool isSectionExpanded() => true;

  @override
  void setSectionExpanded(bool expanded) {}
}
