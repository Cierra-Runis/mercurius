import 'package:mercurius/index.dart';

import '_app_bar_title.dart';
import '_search_button.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    return Scaffold(
      appBar: AppBar(
        leading: const SearchButton(),
        title: AppBarTitle(controller: controller),
      ),
      body: _HomePageBody(controller: controller),
      floatingActionButton: const _FloatingButton(),
    );
  }
}

class _HomePageBody extends ConsumerWidget {
  const _HomePageBody({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(pathsProvider);
    final settings = ref.watch(settingsProvider);

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: BasedLocalFirstImage(
            filename: settings.bgImgPath ?? '',
            localDirectory: path.image.path,
          ),
        ),
      ),
      child: _DiaryListView(
        controller: controller,
      ),
    );
  }
}

class _FloatingButton extends StatelessWidget {
  const _FloatingButton();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      direction: Axis.vertical,
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _ThisDayLastYearButton(),
        _EditingButton(),
        _CreateButton(),
      ],
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  void _createDiary(BuildContext context) async {
    final belongTo = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      initialDate: DateTimeExtension.today,
      firstDate: DateTime(1949, 10),
      lastDate: DateTimeExtension.today.add(
        const Duration(days: 20000),
      ),
    );

    if (context.mounted && belongTo != null) {
      final today = DateTimeExtension.today;
      final diary = Diary(
        id: isarService.diarysAutoIncrement(),
        belongTo: belongTo,
        editAt: today,
        createAt: today,
        content: Document().toDelta().toJson(),
        editing: true,
      );
      context.push(
        EditorPage(diary: diary, autoSave: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return FloatingActionButton(
      heroTag: 'create',
      tooltip: l10n.createNewDiary,
      onPressed: () => _createDiary(context),
      child: const Icon(UniconsLine.diary),
    );
  }
}

class _EditingButton extends HookWidget {
  const _EditingButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final stream = useMemoized(isarService.listenEditingDiaries);
    final snapshot = useStream(stream);
    final data = snapshot.data;
    final hasData = data != null && data.isNotEmpty;
    if (!hasData) return const SizedBox();

    return FloatingActionButton.small(
      tooltip: l10n.continueEditingDiary,
      onPressed: () => context.pushDialog(
        const _EditingDialog(),
      ),
      child: const Icon(Icons.drafts_rounded),
    );
  }
}

class _EditingDialog extends HookWidget {
  const _EditingDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final stream = useMemoized(isarService.listenEditingDiaries);
    final snapshot = useStream(stream);

    final data = snapshot.data;
    final hasData = data != null && data.isNotEmpty;

    return AlertDialog(
      title: Text(l10n.continueEditingDiary),
      content: SizedBox(
        width: double.maxFinite,
        child: !hasData
            ? Text(l10n.noData)
            : ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => FrameSeparateWidget(
                  index: index,
                  placeHolder: const DiaryListItemPlaceholder(),
                  child: DiaryListItem(
                    onTap: () {
                      context.pop();
                      context.push(EditorPage(diary: data[index]));
                    },
                    diary: data[index],
                  ),
                ),
              ),
      ),
    );
  }
}

class _ThisDayLastYearButton extends HookWidget {
  const _ThisDayLastYearButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final stream = useMemoized(
      () => isarService.listenDiariesBetween(
        DateTimeExtension.today.previousYear,
        DateTimeExtension.today.previousYear.nextDay.subSeconds(1),
      ),
    );

    final snapshot = useStream(stream);
    final data = snapshot.data;

    final hasData = data != null && data.isNotEmpty;
    if (!hasData) return const SizedBox();

    return FloatingActionButton.small(
      heroTag: 'thisDayLastYear',
      tooltip: l10n.thisDayLastYear,
      onPressed: () => context.pushDialog(
        const _ThisDayLastYearDialog(),
      ),
      child: const Icon(Icons.nights_stay_rounded),
    );
  }
}

class _ThisDayLastYearDialog extends HookWidget {
  const _ThisDayLastYearDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final stream = useMemoized(
      () => isarService.listenDiariesBetween(
        DateTimeExtension.today.previousYear,
        DateTimeExtension.today.previousYear.nextDay.subSeconds(1),
      ),
    );

    final snapshot = useStream(stream);
    final data = snapshot.data;

    final hasData = data != null && data.isNotEmpty;
    if (!hasData) return const SizedBox();

    return AlertDialog(
      title: Text(l10n.thisDayLastYear),
      content: SizedBox(
        width: double.maxFinite,
        child: !hasData
            ? Text(l10n.noData)
            : ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => FrameSeparateWidget(
                  index: index,
                  placeHolder: const DiaryListItemPlaceholder(),
                  child: DiaryListItem(
                    onTap: () => context.push(
                      DiaryPageView(
                        initialId: data[index].id,
                      ),
                    ),
                    diary: data[index],
                  ),
                ),
              ),
      ),
    );
  }
}

class _DiaryListViewSection {
  const _DiaryListViewSection({
    required this.items,
    required this.header,
  });

  final String header;
  final List<Diary> items;
}

class _DiaryListView extends HookWidget {
  const _DiaryListView({required this.controller});

  final ScrollController controller;

  List<_DiaryListViewSection> _parseDiaries(
    List<Diary> diaries,
    String lang,
  ) {
    final sections = <_DiaryListViewSection>[];

    var year = diaries[0].belongTo.year;
    var month = diaries[0].belongTo.month;
    sections.add(
      _DiaryListViewSection(
        header: diaries[0].belongTo.format(DateFormat.YEAR_ABBR_MONTH, lang),
        items: [],
      ),
    );

    for (final diary in diaries) {
      if (diary.belongTo.month == month && diary.belongTo.year == year) {
        sections.last.items.add(diary);
      } else {
        month = diary.belongTo.month;
        year = diary.belongTo.year;
        sections.add(
          _DiaryListViewSection(
            header: diary.belongTo.format(DateFormat.YEAR_ABBR_MONTH, lang),
            items: [diary],
          ),
        );
      }
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lang = Localizations.localeOf(context).toLanguageTag();
    final stream = useMemoized(isarService.listenAllDiaries);
    final snapshot = useStream(stream);
    final data = snapshot.data;
    final hasData = data != null && data.isNotEmpty;

    if (!hasData) {
      return Center(child: Text(l10n.noData));
    }

    final sections = _parseDiaries(snapshot.data!, lang);

    return ListView.builder(
      cacheExtent: 1000,
      controller: controller,
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return ExpansionTile(
          key: PageStorageKey<String>(section.header),
          initiallyExpanded: true,
          leading: const AppIcon(size: 28),
          title: Text(section.header),
          trailing: Text(l10n.diaryCount(section.items.length)),
          children: section.items
              .map(
                (e) => FrameSeparateWidget(
                  placeHolder: const DiaryListItemPlaceholder(),
                  child: DiaryListItem(
                    dismissDirection: DismissDirection.endToStart,
                    diary: e,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
