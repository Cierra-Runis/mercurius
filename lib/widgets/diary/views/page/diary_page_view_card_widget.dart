import 'package:mercurius/index.dart';

class DiaryPageViewCardWidget extends ConsumerWidget {
  const DiaryPageViewCardWidget({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);
    final String lang = Localizations.localeOf(context).toLanguageTag();

    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: SizedBox(
            child: Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                color: Theme.of(context).colorScheme.background,
                shadows: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15.0,
                    spreadRadius: 4.0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30.0,
                      horizontal: 24.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          diary.createDateTime.format('dd'),
                          style: const TextStyle(
                            fontSize: 60,
                            fontFamily: 'Saira',
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
                              diary.latestEditTime
                                  .format('EEEE HH:mm:ss', lang),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: DiaryEditorBodyWidget(
                        readOnly: true,
                        scrollController: ScrollController(),
                        quillController: QuillController(
                          document: diary.document,
                          selection: const TextSelection.collapsed(offset: 0),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    indent: 8,
                    endIndent: 8,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                Mercurius.vibration(ref: ref);
                                bool? confirm =
                                    await MercuriusConfirmDialogWidget(
                                  title: l10n.areYouSureToDeleteTheDiary,
                                  summary: l10n
                                      .pleaseThinkTwiceAboutDeletingTheDiary,
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
                              onPressed: () async {
                                Mercurius.vibration(ref: ref);
                                await _showDiaryEditorPage(context, diary);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            DiaryPageViewShareButtonWidget(
                              ref: ref,
                              diary: diary,
                              lang: lang,
                              l10n: l10n,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CloseButton(
              onPressed: () {
                Mercurius.vibration(ref: ref);
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showDiaryEditorPage(BuildContext context, Diary diary) {
    return Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => EditorPage(
          diary: diary,
        ),
      ),
    );
  }
}
