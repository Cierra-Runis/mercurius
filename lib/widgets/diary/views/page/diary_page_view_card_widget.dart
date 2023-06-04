import 'package:mercurius/index.dart';

class DiaryPageViewCardWidget extends ConsumerWidget {
  const DiaryPageViewCardWidget({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                          diary.createDateTime.format('dd', 'zh_CN'),
                          style: const TextStyle(
                            fontSize: 60,
                            fontFamily: 'Saira',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              diary.createDateTime.format('y 年，M 月', 'zh_CN'),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              diary.latestEditTime
                                  .format('EEEE HH:mm:ss', 'zh_CN'),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Chip(
                              label: Text(diary.moodType.mood),
                              labelPadding: EdgeInsets.zero,
                            ),
                            Chip(
                              label: Text(diary.weatherType.weather),
                              labelPadding: EdgeInsets.zero,
                            ),
                            Chip(
                              label: Text('${diary.words} 字'),
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
                        controller: QuillController(
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
                                await _showDiaryEditorPage(
                                  context,
                                  diary,
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                Mercurius.vibration(ref: ref);
                                Share.share(
                                  '${diary.createDateTime.format('y 年 M 月 d 日 EEEE', 'zh_CN')}\n'
                                  '天气：${diary.weatherType.weather}\n'
                                  '标题：${diary.titleString == '' ? '无标题' : diary.titleString}\n'
                                  '心情：${diary.moodType.mood}\n'
                                  '\n'
                                  '${diary.document.toPlainText().trimRight()}',
                                );
                              },
                              icon: const Icon(UniconsLine.share),
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
        builder: (context) => DiaryEditorPage(
          diary: diary,
        ),
      ),
    );
  }
}
