import 'package:mercurius/index.dart';

class DiaryPageView extends StatefulWidget {
  const DiaryPageView({
    super.key,
    required this.initialId,
  });

  final int initialId;

  @override
  State<DiaryPageView> createState() => _DiaryPageViewState();
}

class _DiaryPageViewState extends State<DiaryPageView> {
  final stream = isarService.listenToAllDiaries();

  Widget _getPageBySnapshotData(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
  ) {
    final l10n = context.l10n;

    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return AlertDialog(title: Center(child: Text(l10n.noData)));
    }

    final diaries = snapshot.data!;

    /// FIXME: 问题见 https://github.com/flutter/flutter/issues/45632
    return PageView.builder(
      itemCount: diaries.length,
      controller: PageController(
        /// TIPS: diaries maybe random
        initialPage: diaries.indexWhere((e) => e.id == widget.initialId),
      ),
      allowImplicitScrolling: true,
      itemBuilder: (context, index) => _DiaryPageItem(
        key: ValueKey(diaries[index].id),
        diary: diaries[index],
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
        return _getPageBySnapshotData(context, snapshot);
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

class _DiaryPageItem extends StatelessWidget {
  const _DiaryPageItem({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Column(
              children: [
                _BelongTo(diary: diary),
                if (diary.title.isNotEmpty) _Title(diary: diary),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: EditorBody(
              readOnly: true,
              controller: QuillController(
                document: diary.document,
                selection: const TextSelection.collapsed(offset: 0),
              ),
              scrollController: ScrollController(),
            ),
          ),
        ],
      ),

      /// TIPS: https://github.com/flutter/flutter/issues/141922
      persistentFooterAlignment: AlignmentDirectional.centerStart,
      persistentFooterButtons: [
        if (diary.moodType != null) _MoodChip(moodType: diary.moodType!),
        if (diary.weatherType != null)
          _WeatherChip(weatherType: diary.weatherType!),
        _WordsChip(diary: diary),
      ],
      bottomNavigationBar: BottomAppBar(
        child: Wrap(
          spacing: 4,
          runAlignment: WrapAlignment.center,
          children: [
            IconButton(
              color: context.colorScheme.error,
              onPressed: () async {
                final confirm = await ConfirmDialog(
                  title: l10n.areYouSureToDeleteTheDiary,
                  summary: l10n.pleaseThinkTwiceAboutDeletingTheDiary,
                  context: context,
                ).confirm;
                if (confirm == ConfirmResult.confirm) {
                  isarService.deleteDiaryById(diary.id);
                }
              },
              icon: const Icon(Icons.delete_outline_rounded),
            ),
            _DiaryShareButton(
              diary: diary,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          EditorPage(diary: diary),
        ),
        child: const Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}

class _BelongTo extends StatelessWidget {
  const _BelongTo({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).toLanguageTag();

    return Text(
      diary.belongTo.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang),
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}

class _WordsChip extends StatelessWidget {
  const _WordsChip({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Chip(label: Text(l10n.wordCount(diary.words)));
  }
}

class _WeatherChip extends StatelessWidget {
  const _WeatherChip({required this.weatherType});

  final DiaryWeatherType weatherType;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Chip(
      avatar: Icon(weatherType.qweatherIcons.iconData),
      label: Text(l10n.weatherText(weatherType.weather)),
    );
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({required this.moodType});

  final DiaryMoodType moodType;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Chip(
      avatar: Icon(moodType.iconData),
      label: Text(l10n.moodText(moodType.mood)),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(diary.title, style: const TextStyle(fontSize: 16));
  }
}

class _DiaryShareButton extends StatelessWidget {
  const _DiaryShareButton({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lang = Localizations.localeOf(context).toLanguageTag();
    final weatherType = diary.weatherType;
    final moodType = diary.moodType;

    return IconButton(
      onPressed: () {
        try {
          Share.share(
            [
              diary.belongTo.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang),
              '${l10n.title} - ${diary.title.isEmpty ? l10n.untitled : diary.title}',
              if (weatherType != null)
                '${l10n.weather} - ${l10n.weatherText(weatherType.weather)}',
              if (moodType != null)
                '${l10n.mood} - ${l10n.moodText(moodType.mood)}',
              '',
              '--- ${l10n.content} ---',
              '',
              diary.plainText,
            ].join('\n'),
          );
        } catch (e, s) {
          App.printLog('Share Failed', error: e, stackTrace: s);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Share Failed')),
          );
        }
      },
      icon: const Icon(UniconsLine.share),
    );
  }
}
