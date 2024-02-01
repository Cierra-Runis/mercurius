import 'package:mercurius/index.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();

    return Scaffold(
      appBar: AppBar(
        leading: const _SearchButton(),
        title: _AppBarTitle(
          controller: controller,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Badge(
              backgroundColor: Colors.green,
              child: Icon(Icons.dns_rounded),
            ),
          ),
        ],
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

    return SearchAnchor(
      builder: (context, controller) => IconButton(
        onPressed: controller.openView,
        icon: const Icon(Icons.search),
      ),
      viewBuilder: (suggestions) => suggestions.isEmpty
          ? Center(child: Text(l10n.noData))
          : ListView.builder(
              cacheExtent: 1000,
              itemCount: suggestions.length,
              itemBuilder: (context, index) => suggestions.elementAt(index),
            ),
      suggestionsBuilder: (context, controller) async {
        if (controller.text.isEmpty) {
          return [];
        }
        final regex = RegExp(controller.text);
        final diaries = await isarService.getAllDiaries();
        final filteredDiaries = diaries.where(
          (element) => element.plainText.contains(regex),
        );

        return filteredDiaries.map(
          (diary) => _ListTile(
            diary: diary,
            regex: regex,
          ),
        );
      },
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.diary,
    required this.regex,
  });

  final Diary diary;
  final RegExp regex;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).toLanguageTag();
    final primaryColor = Theme.of(context).colorScheme.primary;
    final createAt = diary.createAt.format(
      DateFormat.ABBR_MONTH_WEEKDAY_DAY,
      lang,
    );
    final strings = diary.plainText.split(regex);

    final spans = strings
        .map((e) => TextSpan(text: e))
        .joinSeparator(
          TextSpan(
            text: regex.pattern,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
        .skip(1)
        .toList();

    return ListTile(
      title: Text(createAt),
      subtitle: Text.rich(
        TextSpan(children: spans),
        style: const TextStyle(fontSize: 10),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => context.push(DiaryPageView(diary: diary)),
    );
  }
}

extension ListExtension<E> on Iterable<E> {
  Iterable<E> joinSeparator(E separator) {
    final iterator = this.iterator;
    final result = <E>[];
    if (!iterator.moveNext()) return result;
    result.add(iterator.current);
    if (!iterator.moveNext()) return result;

    do {
      result.add(separator);
      result.add(iterator.current);
    } while (iterator.moveNext());

    return result;
  }
}

class _AppBarTitle extends ConsumerWidget {
  const _AppBarTitle({
    required this.controller,
  });

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
  const _HomePageBody({
    required this.controller,
  });

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
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: DiaryListView(
            controller: controller,
          ),
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
    final dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      initialDate: DateTime.now(),
      firstDate: DateTime(1949, 10),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );

    if (context.mounted && dateTime != null) {
      final diary = Diary(
        id: isarService.diarysAutoIncrement(),
        createAt: dateTime,
        editAt: dateTime,
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
                  onTap: () => context.push(
                    DiaryPageItem(diary: diaries[index]),
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
