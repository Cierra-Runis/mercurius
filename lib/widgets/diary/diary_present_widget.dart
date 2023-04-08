import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryPresentPageView extends StatelessWidget {
  const DiaryPresentPageView({
    Key? key,
    required this.diary,

    /// TODO: 想办法不传入 diaries
    /// FIXME: 存在问题，各 DiaryListCardWidget 的 diaries 属性并不会同步修改
    required this.diaries,
  }) : super(key: key);

  final Diary diary;
  final List<Diary> diaries;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(
        initialPage: diaries.indexOf(diary),
      ),
      children: [
        for (Diary diary in diaries) DiaryPresentDialogWidget(diary: diary),
      ],
    );
  }
}

class DiaryPresentDialogWidget extends StatefulWidget {
  const DiaryPresentDialogWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryPresentDialogWidget> createState() =>
      _DiaryPresentDialogWidgetState();
}

class _DiaryPresentDialogWidgetState extends State<DiaryPresentDialogWidget> {
  Diary _currentDiary = Diary();
  late Diary? futureDiary;
  late Diary? pastDiary;

  @override
  void initState() {
    super.initState();
    _currentDiary = widget.diary;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
              SizedBox(
                height: 134,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_currentDiary.createDateTime.toString().substring(0, 4)}年，${_currentDiary.createDateTime.toString().substring(5, 7)}月',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _currentDiary.createDateTime
                                  .toString()
                                  .substring(8, 10),
                              style: const TextStyle(
                                fontSize: 60,
                                fontFamily: 'Saira',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  size: 8,
                                  QWeatherIcon.getIconById(
                                    int.parse(_currentDiary.weather),
                                  ),
                                ),
                                Text(
                                  '${DiaryConstance.weekdayMap[_currentDiary.createDateTime.weekday]!} ${_currentDiary.latestEditTime.toString().substring(11, 19)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Icon(
                                  size: 9,
                                  DiaryConstance.moodMap[_currentDiary.mood] ??
                                      DiaryConstance.moodMap['开心'],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
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
                  child: flutter_quill.QuillEditor(
                    locale: const Locale('zh', 'CN'),
                    focusNode: FocusNode(),
                    scrollController: ScrollController(),
                    scrollable: true,
                    expands: false,
                    padding: const EdgeInsets.all(4.0),
                    autoFocus: false,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    enableSelectionToolbar: false,
                    controller: flutter_quill.QuillController(
                      document: flutter_quill.Document.fromJson(
                        jsonDecode(_currentDiary.contentJsonString!),
                      ),
                      selection: const TextSelection.collapsed(offset: 0),
                    ),
                    onLaunchUrl: (url) {
                      launchUrlString(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    readOnly: true,
                    scrollBottomInset: 10,
                    customStyles: flutter_quill.DefaultStyles(
                      placeHolder: flutter_quill.DefaultTextBlockStyle(
                        TextStyle(
                          fontFamily: 'Saira',
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        const flutter_quill.VerticalSpacing(0, 0),
                        const flutter_quill.VerticalSpacing(0, 0),
                        null,
                      ),
                      paragraph: flutter_quill.DefaultTextBlockStyle(
                        TextStyle(
                          fontFamily: 'Saira',
                          fontSize: 14,
                          height: 1.5,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                        const flutter_quill.VerticalSpacing(0, 0),
                        const flutter_quill.VerticalSpacing(0, 0),
                        null,
                      ),
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
                          onPressed: () {
                            Navigator.pop(context);
                            isarService.deleteDiaryById(
                              _currentDiary.id!,
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            Diary? editedDiary = await _showDiaryEditorPage(
                              context,
                              _currentDiary,
                            );
                            setState(() {
                              _currentDiary = editedDiary ?? _currentDiary;
                            });
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => Share.share(
                            '${_currentDiary.createDateTime.toString().substring(0, 10)}\n'
                            '天气：${DiaryConstance.weatherCommitMap[_currentDiary.weather] ?? '未记录'}\n'
                            '标题：${_currentDiary.titleString ?? '无标题'}\n'
                            '心情：${_currentDiary.mood}\n'
                            '\n'
                            '${flutter_quill.Document.fromJson(
                              jsonDecode(_currentDiary.contentJsonString!),
                            ).toPlainText().trimRight()}',
                          ),
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
    );
  }

  Future<Diary?> _showDiaryEditorPage(BuildContext context, Diary diary) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiaryEditorPage(
          diary: diary,
        ),
      ),
    );
  }
}
