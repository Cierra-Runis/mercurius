import 'package:mercurius/index.dart';

class DiaryListViewWidget extends ConsumerWidget {
  const DiaryListViewWidget({
    super.key,
    required this.controller,
  });
  final ScrollController controller;

  Widget _getCardBySnapshotData(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
  ) {
    final l10n = context.l10n;
    final String lang = Localizations.localeOf(context).toLanguageTag();

    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return Center(child: Text(l10n.noData));
    }

    List<_DiaryListViewSection> sections = [];
    List<Diary> diaries = snapshot.data!;

    int year = diaries[0].createDateTime.year;
    int month = diaries[0].createDateTime.month;
    sections.add(
      _DiaryListViewSection()
        ..header =
            diaries[0].createDateTime.format(DateFormat.YEAR_ABBR_MONTH, lang),
    );

    for (Diary diary in diaries) {
      if (diary.createDateTime.month == month &&
          diary.createDateTime.year == year) {
        sections.last.items.add(diary);
      } else {
        month = diary.createDateTime.month;
        year = diary.createDateTime.year;
        sections.add(
          _DiaryListViewSection()
            ..header =
                diary.createDateTime.format(DateFormat.YEAR_ABBR_MONTH, lang)
            ..items.add(diary),
        );
      }
    }

    return ExpandableListView(
      cacheExtent: 1000,
      controller: controller,
      builder: SliverExpandableChildDelegate<Diary, _DiaryListViewSection>(
        sectionList: sections,
        headerBuilder: (context, sectionIndex, index) {
          return ColoredBox(
            color: context.colorScheme.background,
            child: BasedListTile(
              leading: const AppIcon(size: 28),
              titleText: sections[sectionIndex].header,
              trailing: Text(
                l10n.diaryCount(sections[sectionIndex].items.length),
              ),
              enabled: false,
            ),
          );
        },
        itemBuilder: (context, sectionIndex, itemIndex, index) {
          return FrameSeparateWidget(
            index: index,
            placeHolder: const DiaryListItemPlaceHolderWidget(),
            child: DiaryListItemWidget(
              diary: sections[sectionIndex].items[itemIndex],
            ),
          );
        },
      ),
    );
  }

  Widget _getBodyBySnapshotState(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
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
        return _getCardBySnapshotData(context, snapshot);
      case ConnectionState.done:
        return const Center(child: Text('Stream closed'));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Diary>>(
      stream: isarService.listenToAllDiaries(),
      builder: _getBodyBySnapshotState,
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
