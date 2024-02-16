import 'package:mercurius/index.dart';

class SearchPage extends StatefulHookWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(
            hintText: l10n.searchHint,
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: _controller.clear,
              icon: const Icon(Icons.clear_rounded),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          return _ViewContent(text: value.text);
        },
      ),
    );
  }
}

class _ViewContent extends StatefulWidget {
  const _ViewContent({
    required this.text,
  });

  final String text;

  @override
  State<_ViewContent> createState() => _ViewContentState();
}

class _ViewContentState extends State<_ViewContent> {
  final stream = isarService.listenToAllDiaries();

  Widget _getCardBySnapshotData(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
  ) {
    final l10n = context.l10n;

    if (widget.text.isEmpty ||
        snapshot.data == null ||
        snapshot.data!.isEmpty) {
      return Center(child: Text(l10n.noData));
    }

    final diaries = snapshot.data!;

    final pattern = widget.text.tryParse();
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
          return FrameSeparateWidget(
            index: index,
            child: _ListTile(
              diary: filteredDiaries[index],
              pattern: pattern,
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
    return StreamBuilder(
      stream: stream,
      builder: _getBodyBySnapshotState,
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.diary,
    required this.pattern,
  });

  final Diary diary;
  final Pattern pattern;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final lang = Localizations.localeOf(context).toLanguageTag();

    final title = diary.title.isNotEmpty
        ? diary.title
        : diary.createAt.format(
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
        text: diary.plainText,
        pattern: pattern,
        textStyle: TextStyle(color: colorScheme.outline, fontSize: 10),
        spansTransform: (spans) => spans.skip(1).toList(),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
      onTap: () => context.pushDialog(
        DiaryPageView(initialId: diary.id),
      ),
    );
  }
}
