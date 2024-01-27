import 'package:mercurius/index.dart';

class DiaryListView extends ConsumerStatefulWidget {
  const DiaryListView({
    super.key,
    required this.controller,
  });
  final ScrollController controller;

  @override
  ConsumerState<DiaryListView> createState() => _DiaryListViewState();
}

class _DiaryListViewState extends ConsumerState<DiaryListView> {
  late final stream = isarService.listenToAllDiaries();

  Widget _getCardBySnapshotData(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
  ) {
    final l10n = context.l10n;
    final lang = Localizations.localeOf(context).toLanguageTag();

    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return Center(child: Text(l10n.noData));
    }

    final sections = <_DiaryListViewSection>[];
    final diaries = snapshot.data!;

    var year = diaries[0].createAt.year;
    var month = diaries[0].createAt.month;
    sections.add(
      _DiaryListViewSection()
        ..header = diaries[0].createAt.format(DateFormat.YEAR_ABBR_MONTH, lang),
    );

    for (final diary in diaries) {
      if (diary.createAt.month == month && diary.createAt.year == year) {
        sections.last.items.add(diary);
      } else {
        month = diary.createAt.month;
        year = diary.createAt.year;
        sections.add(
          _DiaryListViewSection()
            ..header = diary.createAt.format(DateFormat.YEAR_ABBR_MONTH, lang)
            ..items.add(diary),
        );
      }
    }

    return ExpandableListView(
      cacheExtent: 1000,
      controller: widget.controller,
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
            placeHolder: const DiaryListItemPlaceholder(),
            child: DiaryListItem(
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
  Widget build(BuildContext context) {
    return StreamBuilder<List<Diary>>(
      stream: stream,
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
