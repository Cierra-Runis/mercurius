import 'package:mercurius/index.dart';

class DiaryPageViewBodyWidget extends StatefulWidget {
  const DiaryPageViewBodyWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryPageViewBodyWidget> createState() =>
      _DiaryPageViewBodyWidgetState();
}

class _DiaryPageViewBodyWidgetState extends State<DiaryPageViewBodyWidget> {
  late Diary _currentDiary;

  @override
  void initState() {
    super.initState();
    _currentDiary = widget.diary;
  }

  @override
  Widget build(BuildContext context) {
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
                                  _currentDiary.createDateTime
                                      .format('y 年，M 月', 'zh_CN'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _currentDiary.createDateTime
                                      .format('dd', 'zh_CN'),
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
                                      QWeatherIcon.getIconDataById(
                                        int.parse(_currentDiary.weather),
                                      ),
                                    ),
                                    Text(
                                      _currentDiary.latestEditTime
                                          .format('EEEE HH:mm:ss', 'zh_CN'),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Icon(
                                      size: 9,
                                      DiaryConstance
                                              .moodMap[_currentDiary.mood] ??
                                          DiaryConstance.moodMap['开心'],
                                    ),
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
                            jsonDecode(_currentDiary.contentJsonString!),
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
                                bool? confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) =>
                                      const MercuriusOriginalConfirmDialogWidget(
                                    itemName: '这篇日记',
                                  ),
                                );
                                if (confirm == true) {
                                  isarService.deleteDiaryById(
                                    _currentDiary.id!,
                                  );
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
                                Diary? editedDiary = await _showDiaryEditorPage(
                                  context,
                                  _currentDiary,
                                );
                                if (mounted) {
                                  setState(() {
                                    _currentDiary =
                                        editedDiary ?? _currentDiary;
                                  });
                                }
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                MercuriusKit.vibration();
                                Share.share(
                                  '${_currentDiary.createDateTime.format('y 年 M 月 d 日 EEEE', 'zh_CN')}\n'
                                  '天气：${DiaryConstance.weatherCommitMap[_currentDiary.weather] ?? '未记录'}\n'
                                  '标题：${_currentDiary.titleString ?? '无标题'}\n'
                                  '心情：${_currentDiary.mood}\n'
                                  '\n'
                                  '${Document.fromJson(
                                    jsonDecode(
                                        _currentDiary.contentJsonString!),
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

  Future<Diary?> _showDiaryEditorPage(BuildContext context, Diary diary) {
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
