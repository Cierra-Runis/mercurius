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

  @override
  void initState() {
    super.initState();
    diaryEditorModel.init(widget.diary);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryEditorModel>(
      builder: (context, diaryEditorModel, child) {
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
                                  '${diaryEditorModel.diary.createDateTime.toString().substring(0, 4)}年，${diaryEditorModel.diary.createDateTime.toString().substring(5, 7)}月',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  diaryEditorModel.diary.createDateTime
                                      .toString()
                                      .substring(8, 10),
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
                                      QWeatherIcon.getIconById(
                                        int.parse(
                                            diaryEditorModel.diary.weather),
                                      ),
                                    ),
                                    Text(
                                      '${DiaryConstance.weekdayMap[diaryEditorModel.diary.createDateTime.weekday]!} ${widget.diary.latestEditTime.toString().substring(11, 19)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Icon(
                                      size: 9,
                                      DiaryConstance.moodMap[
                                              diaryEditorModel.diary.mood] ??
                                          DiaryConstance.moodMap['开心'],
                                    ),
                                  ],
                                )
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
                    thickness: 1.2,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: flutter_quill.QuillEditor(
                        locale: const Locale('zh', 'cn'),
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
                            jsonDecode(
                                diaryEditorModel.diary.contentJsonString!),
                          ),
                          selection: const TextSelection.collapsed(offset: 0),
                        ),
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
                            const Tuple2(0, 0),
                            const Tuple2(0, 0),
                            null,
                          ),
                          paragraph: flutter_quill.DefaultTextBlockStyle(
                            TextStyle(
                              fontFamily: 'Saira',
                              fontSize: 14,
                              height: 1.5,
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                            ),
                            const Tuple2(0, 0),
                            const Tuple2(0, 0),
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
                    thickness: 1.2,
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
                                DevTools.printLog(
                                  '${diaryEditorModel.diary.id!}',
                                );
                                isarService.deleteDiaryById(
                                  diaryEditorModel.diary.id!,
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiaryEditorPage(
                                    diary: diaryEditorModel.diary,
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => Share.share(
                                flutter_quill.Document.fromJson(
                                  jsonDecode(diaryEditorModel
                                      .diary.contentJsonString!),
                                ).toPlainText(),
                              ),
                              icon: const Icon(UniconsLine.share),
                            ),
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
      },
    );
  }
}
