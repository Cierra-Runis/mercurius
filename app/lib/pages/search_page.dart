import 'package:mercurius/index.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _SearchBar(),
        actions: const [_HelperButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: Material(
              shape: Border(
                bottom: Divider.createBorderSide(context, width: 1.0),
              ),
              child: const _ViewContent(),
            ),
          ),
          const _BottomActions(),
        ],
      ),
    );
  }
}

class _HelperButton extends StatelessWidget {
  const _HelperButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IconButton(
      tooltip: l10n.whatIsRegularExpression,
      onPressed: () async {
        try {
          await launchUrlString(
            l10n.regularExpressionDoc,
            mode: LaunchMode.externalApplication,
          );
        } catch (e, s) {
          App.printLog('Launch doc error', error: e, stackTrace: s);
        }
      },
      icon: const Icon(Icons.help_rounded),
    );
  }
}

class _BottomActionModel {
  const _BottomActionModel({
    required this.label,
    required this.avatar,
    required this.selected,
    required this.onSelected,
    this.tooltip,
  });

  final String label;
  final Widget avatar;
  final bool Function(AdvanceSearchState advanceSearch) selected;
  final void Function(bool value, AdvanceSearch setAdvanceSearch) onSelected;
  final String? tooltip;
}

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final models = [
      _BottomActionModel(
        label: l10n.multiLine,
        avatar: const Icon(Icons.notes_rounded),
        tooltip: l10n.multiLineTooltip,
        selected: (advanceSearch) => advanceSearch.multiLine,
        onSelected: (value, setAdvanceSearch) => setAdvanceSearch
            .changeTo((state) => state.copyWith(multiLine: value)),
      ),
      _BottomActionModel(
        label: l10n.caseSensitive,
        avatar: const Icon(Icons.abc_rounded),
        tooltip: l10n.caseSensitiveTooltip,
        selected: (advanceSearch) => advanceSearch.caseSensitive,
        onSelected: (value, setAdvanceSearch) => setAdvanceSearch
            .changeTo((state) => state.copyWith(caseSensitive: value)),
      ),
      _BottomActionModel(
        label: l10n.unicode,
        avatar: const Icon(Icons.public_rounded),
        tooltip: l10n.unicodeTooltip,
        selected: (advanceSearch) => advanceSearch.unicode,
        onSelected: (value, setAdvanceSearch) => setAdvanceSearch
            .changeTo((state) => state.copyWith(unicode: value)),
      ),
      _BottomActionModel(
        label: l10n.dotAll,
        avatar: const Icon(Icons.star_rounded),
        tooltip: l10n.dotAllTooltip,
        selected: (advanceSearch) => advanceSearch.dotAll,
        onSelected: (value, setAdvanceSearch) =>
            setAdvanceSearch.changeTo((state) => state.copyWith(dotAll: value)),
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.end,
        runAlignment: WrapAlignment.end,
        verticalDirection: VerticalDirection.up,
        children: models.map((e) => _BottomAction(model: e)).toList(),
      ),
    );
  }
}

class _BottomAction extends ConsumerWidget {
  const _BottomAction({
    required this.model,
  });
  final _BottomActionModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = context.colorScheme;
    final advanceSearch = ref.watch(advanceSearchProvider);
    final setAdvanceSearch = ref.watch(advanceSearchProvider.notifier);
    final selected = model.selected(advanceSearch);

    return ChoiceChip.elevated(
      tooltip: model.tooltip,
      avatar: !selected ? model.avatar : null,
      label: Text(model.label),
      checkmarkColor: colorScheme.primary,
      onSelected: (value) => model.onSelected(value, setAdvanceSearch),
      selected: selected,
    );
  }
}

class _SearchBar extends HookConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;
    final textEditingController = useTextEditingController();
    final advanceSearch = ref.watch(advanceSearchProvider);
    final setAdvanceSearch = ref.watch(advanceSearchProvider.notifier);

    return TextField(
      autofocus: true,
      controller: textEditingController,
      onChanged: (value) =>
          setAdvanceSearch.changeTo((state) => state.copyWith(source: value)),
      decoration: InputDecoration(
        hintText: l10n.searchHint,
        suffixIcon: IconButton(
          onPressed: () {
            textEditingController.clear();
            setAdvanceSearch.clear();
          },
          icon: const Icon(Icons.clear_rounded),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color:
                advanceSearch.isRegex ? colorScheme.primary : colorScheme.error,
          ),
        ),
      ),
    );
  }
}

class _ViewContent extends HookWidget {
  const _ViewContent();

  @override
  Widget build(BuildContext context) {
    final result = useMemoized(() => isarService.listenToAllDiaries());
    final snapshot = useStream(result);

    if (snapshot.hasError) {
      return Center(child: Text('Steam error: ${snapshot.error}'));
    }
    return switch (snapshot.connectionState) {
      ConnectionState.none =>
        const Center(child: Icon(UniconsLine.data_sharing)),
      ConnectionState.waiting => const Loading(),
      ConnectionState.active => _View(snapshot: snapshot),
      ConnectionState.done => const Center(child: Text('Stream closed')),
    };
  }
}

class _View extends ConsumerWidget {
  const _View({required this.snapshot});

  final AsyncSnapshot<List<Diary>> snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final advanceSearch = ref.watch(advanceSearchProvider);

    if (advanceSearch.source.isEmpty ||
        snapshot.data == null ||
        snapshot.data!.isEmpty) {
      return Center(child: Text(l10n.noData));
    }

    final diaries = snapshot.data!;

    final pattern = advanceSearch.pattern;
    final filteredDiaries = diaries
        .where(
          (element) => element.plainText.contains(pattern),
        )
        .toList();

    if (filteredDiaries.isEmpty) {
      return Center(child: Text(l10n.noData));
    }

    return SizeCacheWidget(
      child: ListView.builder(
        cacheExtent: 1000,
        itemCount: filteredDiaries.length,
        itemBuilder: (context, index) {
          final diary = filteredDiaries[index];
          return FrameSeparateWidget(
            index: diary.id,
            child: _ListTile(diary: diary, pattern: pattern),
          );
        },
      ),
    );
  }
}

class _ListTile extends StatefulWidget {
  const _ListTile({
    required this.diary,
    required this.pattern,
  });

  final Diary diary;
  final Pattern pattern;

  @override
  State<_ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<_ListTile> {
  final _controller = HighlightTextController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final lang = Localizations.localeOf(context).toLanguageTag();

    final title = widget.diary.title.isNotEmpty
        ? widget.diary.title
        : widget.diary.belongTo.format(
            DateFormat.YEAR_ABBR_MONTH_DAY,
            lang,
          );

    return ListTile(
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: HighlightText(
        text: widget.diary.plainText,
        pattern: widget.pattern,
        controller: _controller,
        textStyle: TextStyle(color: colorScheme.outline, fontSize: 10),
        spansTransform: (spans) {
          return spans.skip(1).toList();
        },
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
      trailing: Badge(
        label: ListenableBuilder(
          listenable: _controller,
          builder: (context, child) => Text('${_controller.count}'),
        ),
      ),
      onTap: () => context.pushDialog(
        DiaryPageView(initialId: widget.diary.id),
      ),
    );
  }
}
