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

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.end,
        runAlignment: WrapAlignment.end,
        verticalDirection: VerticalDirection.up,
        children: [
          _Multiline(),
          _CaseSensitive(),
          _Unicode(),
          _DotAll(),
        ],
      ),
    );
  }
}

class _CaseSensitive extends ConsumerWidget {
  const _CaseSensitive();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final colorScheme = context.colorScheme;
    final search = ref.watch(searchProvider);
    final setSearch = ref.watch(searchProvider.notifier);

    return ChoiceChip.elevated(
      tooltip: l10n.caseSensitiveTooltip,
      avatar: const Icon(Icons.abc_rounded),
      label: Text(l10n.caseSensitive),
      checkmarkColor: colorScheme.primary,
      onSelected: (value) =>
          setSearch.changeTo(search.copyWith(caseSensitive: value)),
      selected: search.caseSensitive,
    );
  }
}

class _DotAll extends ConsumerWidget {
  const _DotAll();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final colorScheme = context.colorScheme;
    final search = ref.watch(searchProvider);
    final setSearch = ref.watch(searchProvider.notifier);

    return ChoiceChip.elevated(
      tooltip: l10n.dotAllTooltip,
      avatar: const Icon(Icons.star_rounded),
      label: Text(l10n.dotAll),
      checkmarkColor: colorScheme.primary,
      onSelected: (value) => setSearch.changeTo(search.copyWith(dotAll: value)),
      selected: search.dotAll,
    );
  }
}

class _HelperButton extends StatelessWidget {
  const _HelperButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return IconButton(
      onPressed: () => context.pushDialog(
        AlertDialog(
          title: Text(l10n.whatIsRegularExpression),
          content: Text(l10n.regularExpressionIs),
          actions: [
            TextButton(
              onPressed: context.pop,
              child: Text(l10n.back),
            ),
            TextButton(
              onPressed: () => App.launchUrl(l10n.regularExpressionDoc),
              child: Text(l10n.learnMore),
            ),
          ],
        ),
      ),
      icon: const Icon(Icons.help_rounded),
    );
  }
}

class _ListTile extends StatefulWidget {
  final Diary diary;

  final Pattern pattern;
  const _ListTile({
    required this.diary,
    required this.pattern,
  });

  @override
  State<_ListTile> createState() => _ListTileState();
}

class _ListTileState extends State<_ListTile> {
  final _controller = HighlightTextController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final lang = context.languageTag;

    final title = widget.diary.belongTo.format(
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
        textStyle: TextStyle(
          color: colorScheme.outline,
          fontSize: App.fontSize10,
        ),
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
    );
  }
}

class _Multiline extends ConsumerWidget {
  const _Multiline();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final colorScheme = context.colorScheme;
    final search = ref.watch(searchProvider);
    final setSearch = ref.watch(searchProvider.notifier);

    return ChoiceChip.elevated(
      tooltip: l10n.multiLineTooltip,
      avatar: const Icon(Icons.notes_rounded),
      label: Text(l10n.multiLine),
      checkmarkColor: colorScheme.primary,
      onSelected: (value) =>
          setSearch.changeTo(search.copyWith(multiLine: value)),
      selected: search.multiLine,
    );
  }
}

class _SearchBar extends HookConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;
    final search = ref.watch(searchProvider);
    final setSearch = ref.watch(searchProvider.notifier);
    final textEditingController = useTextEditingController(
      text: search.source,
    );

    return TextField(
      autofocus: true,
      controller: textEditingController,
      onChanged: (value) => setSearch.changeTo(
        search.copyWith(source: value),
      ),
      decoration: InputDecoration(
        hintText: l10n.searchHint,
        suffixIcon: IconButton(
          onPressed: () {
            textEditingController.clear();
            setSearch.clear();
          },
          icon: const Icon(Icons.clear_rounded),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: search.isRegex ? colorScheme.primary : colorScheme.error,
          ),
        ),
      ),
    );
  }
}

class _Unicode extends ConsumerWidget {
  const _Unicode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final colorScheme = context.colorScheme;
    final search = ref.watch(searchProvider);
    final setSearch = ref.watch(searchProvider.notifier);

    return ChoiceChip.elevated(
      tooltip: l10n.unicodeTooltip,
      avatar: const Icon(Icons.public_rounded),
      label: Text(l10n.unicode),
      checkmarkColor: colorScheme.primary,
      onSelected: (value) =>
          setSearch.changeTo(search.copyWith(unicode: value)),
      selected: search.unicode,
    );
  }
}

class _ViewContent extends HookConsumerWidget {
  const _ViewContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizeCacheWidget(
      child: ListView.builder(
        cacheExtent: 1000,
        itemBuilder: (context, index) {
          return null;
        },
      ),
    );
  }
}
