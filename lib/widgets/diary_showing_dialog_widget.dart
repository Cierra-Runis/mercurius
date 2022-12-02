import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryShowingDialogWidget extends StatefulWidget {
  const DiaryShowingDialogWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryShowingDialogWidget> createState() =>
      _DiaryShowingDialogWidgetState();
}

class _DiaryShowingDialogWidgetState extends State<DiaryShowingDialogWidget> {
  late Diary? futureDiary;
  late Diary? pastDiary;

  final isarService = IsarService();

  @override
  void initState() {
    diaryEditorModel.init(widget.diary);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryEditorModel>(
        builder: (context, diaryEditorModel, child) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
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
                                '${diaryEditorModel.diary.createDateTime.substring(0, 4)}年，${diaryEditorModel.diary.createDateTime.substring(5, 7)}月',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                diaryEditorModel.diary.createDateTime
                                    .substring(8, 10),
                                style: const TextStyle(
                                  fontSize: 60,
                                  fontFamily: 'Saira',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${Constance.weekdayMap[DateTime.parse(diaryEditorModel.diary.createDateTime).weekday]!} ${widget.diary.latestEditTime.substring(11, 19)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  size: 22,
                                  QWeatherIcon.getIconById(
                                    int.parse(diaryEditorModel.diary.weather),
                                  ),
                                ),
                                Icon(
                                    size: 22,
                                    Constance.moodMap[
                                            diaryEditorModel.diary.mood] ??
                                        Constance.moodMap['开心']),
                              ],
                            )
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
                  thickness: 1.8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    child: flutter_quill.QuillEditor(
                      locale: const Locale('zh', 'hk'),
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
                          jsonDecode(diaryEditorModel.diary.contentJsonString!),
                        ),
                        selection: const TextSelection.collapsed(offset: 0),
                      ),
                      readOnly: true,
                      scrollBottomInset: 10,
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  indent: 8,
                  endIndent: 8,
                  thickness: 1.8,
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
                              isarService
                                  .deleteDiaryById(diaryEditorModel.diary.id!);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiaryEditorPage(
                                    diary: diaryEditorModel.diary,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              Share.share(
                                flutter_quill.Document.fromJson(
                                  jsonDecode(diaryEditorModel
                                      .diary.contentJsonString!),
                                ).toPlainText(),
                              );
                            },
                            icon: const Icon(UniconsLine.share),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
