import 'package:mercurius/index.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();

    return Scaffold(
      appBar: AppBar(
        leading: const _SearchButton(),
        title: _AppBarTitle(controller: controller),
      ),
      body: _HomePageBody(controller: controller),
      floatingActionButton: const _FloatingButton(),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.searchDiary,
      onPressed: () => context.push(const SearchPage()),
      icon: const Icon(Icons.search),
    );
  }
}

class _AppBarTitle extends ConsumerWidget {
  const _AppBarTitle({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPosition = ref.watch(currentPositionProvider);

    return GestureDetector(
      onTap: () => controller.animateTo(
        -WindowAppBar.appBarHeight,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      ),
      child: Column(
        children: [
          const AppName(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                UniconsLine.location_arrow,
                size: 6,
              ),
              Text(
                currentPosition.when(
                  loading: () => ' ${const CurrentPosition().humanFormat} ',
                  error: (error, stackTrace) => 'error',
                  data: (data) => ' ${data.humanFormat} ',
                ),
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
              Icon(
                QWeatherIcons.getIconWith(
                  ref.watch(qWeatherNowProvider).when(
                        data: (data) => data.icon,
                        error: (error, stackTrace) =>
                            QWeatherIcons.tag_unknown_fill.tag,
                        loading: () => QWeatherIcons.tag_1031.tag,
                      ),
                ).iconData,
                size: 6,
              ),
            ],
          ),
          Text(
            currentPosition.when(
              loading: () => const CurrentPosition().city,
              error: (error, stackTrace) => 'error',
              data: (cachePosition) => cachePosition.city,
            ),
            style: const TextStyle(
              fontSize: 8,
            ),
          ),
        ],
      ),
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

    return Stack(
      fit: StackFit.expand,
      children: [
        if (settings.bgImgPath != null)
          Image(
            image: BasedLocalFirstImage(
              filename: settings.bgImgPath!,
              localDirectory: path.imageDirectory.path,
            ),
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
            fit: BoxFit.cover,
          ),
        _DiaryListView(
          controller: controller,
        ),
      ],
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
      initialDate: DateTime.now(),
      firstDate: DateTime(1949, 10),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );

    if (context.mounted && belongTo != null) {
      final now = DateTime.now();
      final diary = Diary(
        id: isarService.diarysAutoIncrement(),
        belongTo: belongTo,
        editAt: now,
        createAt: now,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      onPressed: () => _createDiary(context),
      child: const Icon(UniconsLine.diary),
    );
  }
}

class _EditingButton extends StatefulWidget {
  const _EditingButton();

  @override
  State<_EditingButton> createState() => _EditingButtonState();
}

class _EditingButtonState extends State<_EditingButton> {
  final stream = isarService.listenToDiariesEditing();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return StreamBuilder<List<Diary>>(
      stream: stream,
      builder: (context, snapshot) {
        final hasData = snapshot.hasData && snapshot.data!.isNotEmpty;
        if (!hasData) return const SizedBox();

        return FloatingActionButton.small(
          tooltip: l10n.continueEditingDiary,
          onPressed: () => context.pushDialog(
            const _EditingDialog(),
          ),
          child: const Icon(Icons.drafts_rounded),
        );
      },
    );
  }
}

class _EditingDialog extends StatefulWidget {
  const _EditingDialog();

  @override
  State<_EditingDialog> createState() => _EditingDialogState();
}

class _EditingDialogState extends State<_EditingDialog> {
  final stream = isarService.listenToDiariesEditing();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.continueEditingDiary),
      content: SizedBox(
        width: double.maxFinite,
        child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            final hasData = snapshot.hasData && snapshot.data!.isNotEmpty;
            if (!hasData) return Text(l10n.noData);

            final diaries = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: diaries.length,
              itemBuilder: (context, index) => FrameSeparateWidget(
                index: index,
                placeHolder: const DiaryListItemPlaceholder(),
                child: DiaryListItem(
                  onTap: () {
                    context.pop();
                    context.push(
                      EditorPage(diary: diaries[index]),
                    );
                  },
                  diary: diaries[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ThisDayLastYearButton extends StatefulWidget {
  const _ThisDayLastYearButton();

  @override
  State<_ThisDayLastYearButton> createState() => _ThisDayLastYearButtonState();
}

class _ThisDayLastYearButtonState extends State<_ThisDayLastYearButton> {
  final stream = isarService.listenToDiariesWithDate(
    DateTime.now().previousYear,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return StreamBuilder<List<Diary>>(
      stream: stream,
      builder: (context, snapshot) {
        final hasData = snapshot.hasData && snapshot.data!.isNotEmpty;
        if (!hasData) return const SizedBox();

        return FloatingActionButton.small(
          heroTag: 'thisDayLastYear',
          tooltip: l10n.thisDayLastYear,
          onPressed: () => context.pushDialog(
            const _ThisDayLastYearDialog(),
          ),
          child: const Icon(Icons.nights_stay_rounded),
        );
      },
    );
  }
}

class _ThisDayLastYearDialog extends StatefulWidget {
  const _ThisDayLastYearDialog();

  @override
  State<_ThisDayLastYearDialog> createState() => _ThisDayLastYearDialogState();
}

class _ThisDayLastYearDialogState extends State<_ThisDayLastYearDialog> {
  final stream = isarService.listenToDiariesWithDate(
    DateTime.now().previousYear,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.thisDayLastYear),
      content: SizedBox(
        width: double.maxFinite,
        child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            final hasData = snapshot.hasData && snapshot.data!.isNotEmpty;
            if (!hasData) return Text(l10n.noData);

            final diaries = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: diaries.length,
              itemBuilder: (context, index) => FrameSeparateWidget(
                index: index,
                placeHolder: const DiaryListItemPlaceholder(),
                child: DiaryListItem(
                  onTap: () => context.pushDialog(
                    DiaryPageView(
                      initialId: diaries[index].id,
                    ),
                  ),
                  diary: diaries[index],
                ),
              ),
            );
          },
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

  @override
  Widget build(BuildContext context) {
    final stream = useMemoized(isarService.listenToAllDiaries);
    final snapshot = useStream(stream);

    if (snapshot.hasError) {
      return Center(child: Text('Steam error: ${snapshot.error}'));
    }
    return switch (snapshot.connectionState) {
      ConnectionState.none =>
        const Center(child: Icon(UniconsLine.data_sharing)),
      ConnectionState.waiting => const Loading(),
      ConnectionState.active => _View(
          snapshot: snapshot,
          controller: controller,
        ),
      ConnectionState.done => const Center(child: Text('Stream closed')),
    };
  }
}

class _View extends ConsumerWidget {
  const _View({
    required this.snapshot,
    required this.controller,
  });

  final AsyncSnapshot<List<Diary>> snapshot;
  final ScrollController controller;

  List<_DiaryListViewSection> _parseDiaries(List<Diary> diaries, String lang) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final lang = Localizations.localeOf(context).toLanguageTag();

    if (snapshot.data == null || snapshot.data!.isEmpty) {
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
          shape: const Border(),
          collapsedShape: const Border(),
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
