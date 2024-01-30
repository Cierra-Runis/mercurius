import 'package:mercurius/index.dart';

class DiaryPageItem extends ConsumerWidget {
  const DiaryPageItem({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Column(
              children: [
                _CreateAt(diary: diary),
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
        _MoodChip(diary: diary),
        _WeatherChip(diary: diary),
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
                if (confirm ?? false) {
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

class _CreateAt extends StatelessWidget {
  const _CreateAt({
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).toLanguageTag();

    return Text(
      diary.createAt.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang),
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _WordsChip extends StatelessWidget {
  const _WordsChip({
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Chip(
      label: Text(l10n.wordCount(diary.words)),
    );
  }
}

class _WeatherChip extends StatelessWidget {
  const _WeatherChip({
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Chip(
      avatar: Icon(diary.weatherType.qweatherIcons.iconData),
      label: Text(
        l10n.weatherText(
          diary.weatherType.weather,
        ),
      ),
    );
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Chip(
      avatar: Icon(diary.moodType.iconData),
      label: Text(
        l10n.moodText(
          diary.moodType.mood,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.title,
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class _DiaryShareButton extends ConsumerWidget {
  const _DiaryShareButton({
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final lang = Localizations.localeOf(context).toLanguageTag();

    return IconButton(
      onPressed: () => Share.share(
        '${diary.createAt.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang)}\n'
        '${l10n.title} - ${diary.title.isEmpty ? l10n.untitled : diary.title}\n'
        '${l10n.weather} - ${l10n.weatherText(diary.weatherType.weather)}\n'
        '${l10n.mood} - ${l10n.moodText(diary.moodType.mood)}\n'
        '--- ${l10n.content} ---\n'
        '${diary.document.toPlainText(EditorBody.embedBuilders, EditorBody.unknownEmbedBuilder)}',
      ),
      icon: const Icon(UniconsLine.share),
    );
  }
}
