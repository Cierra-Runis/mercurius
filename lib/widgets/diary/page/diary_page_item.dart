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

    return SafeArea(
      child: Stack(
        children: [
          Card(
            surfaceTintColor: context.colorScheme.background,
            margin: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 20,
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        diary.createDateTime.format('dd'),
                        style: const TextStyle(
                          fontSize: 60,
                          fontFamily: App.fontSaira,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            diary.createDateTime
                                .format(DateFormat.YEAR_ABBR_MONTH, lang),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            diary.latestEditTime.format('E HH:mm:ss', lang),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 4,
                        children: [
                          Chip(
                            label: Text(
                              l10n.moodText(
                                diary.moodType.mood,
                              ),
                            ),
                            labelPadding: EdgeInsets.zero,
                          ),
                          Chip(
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
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  indent: 8,
                  endIndent: 8,
                ),
                Expanded(
                  child: EditorBody(
                    readOnly: true,
                    controller: QuillController(
                      document: diary.document,
                      selection: const TextSelection.collapsed(offset: 0),
                    ),
                    scrollController: ScrollController(),
                  ),
                ),
                const Divider(
                  height: 0,
                  indent: 8,
                  endIndent: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            final confirm = await ConfirmDialog(
                              title: l10n.areYouSureToDeleteTheDiary,
                              summary:
                                  l10n.pleaseThinkTwiceAboutDeletingTheDiary,
                              context: context,
                            ).confirm;
                            if (confirm == true) {
                              isarService.deleteDiaryById(diary.id);
                            }
                          },
                          icon: const Icon(Icons.delete_outline_rounded),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => context.push(
                            EditorPage(diary: diary),
                          ),
                          icon: const Icon(Icons.edit),
                        ),
                        DiaryShareButton(
                          diary: diary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CloseButton(
                onPressed: context.pop,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
