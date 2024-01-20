import 'package:mercurius/index.dart';

class DiaryPageItem extends ConsumerWidget {
  const DiaryPageItem({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;
    final lang = Localizations.localeOf(context).toLanguageTag();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Column(
              children: [
                Text(
                  diary.createAt.format(DateFormat.YEAR_MONTH_DAY, lang),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  diary.editAt.format('E HH:mm:ss', lang),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
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
        Chip(
          avatar: Icon(diary.moodType.iconData),
          label: Text(
            l10n.moodText(
              diary.moodType.mood,
            ),
          ),
          labelPadding: EdgeInsets.zero,
        ),
        Chip(
          avatar: Icon(diary.weatherType.qweatherIcons.iconData),
          label: Text(
            l10n.weatherText(
              diary.weatherType.weather,
            ),
          ),
          labelPadding: EdgeInsets.zero,
        ),
        Chip(
          label: Text(l10n.wordCount(diary.words)),
          labelPadding: EdgeInsets.zero,
        ),
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
            DiaryShareButton(
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
