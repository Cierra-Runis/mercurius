import 'package:mercurius/index.dart';

class DiaryPageViewBodyWidget extends ConsumerWidget {
  const DiaryPageViewBodyWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

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
                  SizedOverflowBox(
                    size: const Size.fromHeight(134),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  diary.createDateTime
                                      .format('y 年，M 月', 'zh_CN'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  diary.createDateTime.format('dd', 'zh_CN'),
                                  style: const TextStyle(
                                    fontSize: 60,
                                    fontFamily: 'Saira',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      size: 8,
                                      diary.weatherType.qweatherIcons.iconData,
                                    ),
                                    Text(
                                      diary.latestEditTime
                                          .format('EEEE HH:mm:ss', 'zh_CN'),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Icon(size: 9, diary.moodType.iconData),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
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
                          document: Document.fromJson(
                            jsonDecode(diary.contentJsonString!),
                          ),
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
                                MercuriusKit.vibration();
                                bool? confirm =
                                    await MercuriusOriginalConfirmDialogWidget(
                                  context: context,
                                ).confirm;
                                if (confirm == true) {
                                  ref
                                      .watch(isarServiceProvider.notifier)
                                      .deleteDiaryById(diary.id);
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
                                MercuriusKit.vibration();
                                await _showDiaryEditorPage(
                                  context,
                                  diary,
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                MercuriusKit.vibration();
                                Share.share(
                                  '${diary.createDateTime.format('y 年 M 月 d 日 EEEE', 'zh_CN')}\n'
                                  '天气：${diary.weatherType.weather}\n'
                                  '标题：${diary.titleString ?? '无标题'}\n'
                                  '心情：${diary.moodType.mood}\n'
                                  '\n'
                                  '${Document.fromJson(
                                    jsonDecode(diary.contentJsonString!),
                                  ).toPlainText().trimRight()}',
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
                MercuriusKit.vibration();
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
