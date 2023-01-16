import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryEditorPage extends StatefulWidget {
  const DiaryEditorPage({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryEditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends State<DiaryEditorPage> {
  late final flutter_quill.QuillController _controller;
  final TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    diaryEditorModel.init(widget.diary);
    _controller = flutter_quill.QuillController(
      document: diaryEditorModel.diary.contentJsonString != null
          ? flutter_quill.Document.fromJson(
              jsonDecode(diaryEditorModel.diary.contentJsonString!),
            )
          : flutter_quill.Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _title.text = diaryEditorModel.diary.titleString ?? '';

    super.initState();
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  /// 遮挡问题 https://github.com/singerdmx/flutter-quill/issues/1017
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryEditorModel>(
      builder: (context, diaryEditorModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: TextButton(
              onPressed: () {
                Vibration.vibrate(duration: 50, amplitude: 255);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  const Size(56, 56),
                ),
              ),
              child: const Text('取消'),
            ),
            title: TextField(
              textAlign: TextAlign.center,
              key: _formKey,
              controller: _title,
              decoration: const InputDecoration(
                hintText: '无标题',
              ),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () {
                  String plainText = jsonEncode(
                    _controller.document
                        .toPlainText()
                        .replaceAll(RegExp(r'\n'), '')
                        .replaceAll(RegExp(r' '), ''),
                  );
                  if (plainText != '""') {
                    Vibration.vibrate(duration: 50, amplitude: 255);
                    diaryEditorModel.diary.contentJsonString = jsonEncode(
                      _controller.document.toDelta().toJson(),
                    );
                    diaryEditorModel.saveDiary();
                    isarService.saveDiary(
                      diaryEditorModel.diary
                        ..latestEditTime = DateTime.now()
                        ..titleString =
                            (_title.text == '' ? null : _title.text),
                    );
                    Navigator.of(context).pop();
                  } else {
                    Vibration.vibrate(duration: 300, amplitude: 255);
                    Flushbar(
                      icon: const Icon(UniconsLine.confused),
                      isDismissible: false,
                      messageText: const Center(
                        child: Text(
                          '内容不能为空',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.fromLTRB(60, 16, 60, 0),
                      barBlur: 1.0,
                      borderRadius: BorderRadius.circular(16),
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF303030).withAlpha(60)
                              : const Color(0xFFCFCFCF).withAlpha(60),
                      boxShadows: const [
                        BoxShadow(
                          color: Colors.transparent,
                          blurRadius: 10.0,
                          spreadRadius: 4.0,
                          offset: Offset(0, 16),
                        ),
                      ],
                      duration: const Duration(
                        milliseconds: 600,
                      ),
                      flushbarPosition: FlushbarPosition.TOP,
                    ).show(context);
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(56, 56),
                  ),
                ),
                child: const Text('保存'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: flutter_quill.QuillEditor(
                    locale: const Locale('zh', 'cn'),
                    focusNode: FocusNode(),
                    scrollController: _scrollController,
                    scrollable: true,
                    expands: false,
                    padding: const EdgeInsets.all(2.0),
                    autoFocus: true,
                    placeholder: '记些什么吧',
                    controller: _controller,
                    readOnly: false,
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
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                        const Tuple2(0, 0),
                        const Tuple2(0, 0),
                        null,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 12,
                  thickness: 1.8,
                ),
                flutter_quill.QuillToolbar.basic(
                  controller: _controller,
                  showUndo: false,
                  showRedo: false,
                  showFontFamily: false,
                  showFontSize: false,
                  showBackgroundColorButton: false,
                  showClearFormat: false,
                  showColorButton: false,
                  showCodeBlock: false,
                  showInlineCode: false,
                  showAlignmentButtons: true,
                  showListBullets: false,
                  showListCheck: false,
                  showListNumbers: false,
                  showJustifyAlignment: false,
                  showDividers: false,
                  showSmallButton: true,
                  showSearchButton: false,
                  showIndent: false,
                  toolbarSectionSpacing: 14,
                  iconTheme: flutter_quill.QuillIconTheme(
                    borderRadius: 12,
                    iconSelectedFillColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).cardColor
                            : Theme.of(context).backgroundColor,
                  ),
                  customButtons: [
                    flutter_quill.QuillCustomButton(
                      icon: UniconsLine.clock,
                      onTap: () {
                        /// TODO: 插入时间
                      },
                    ),
                    flutter_quill.QuillCustomButton(
                      icon: Icons.mood,
                      onTap: () => _selectDiaryMoodDialog(
                        context,
                        diaryEditorModel.diary,
                      ),
                    ),
                  ],
                  locale: const Locale('zh', 'cn'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDiaryMoodDialog(BuildContext context, Diary diary) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _DiaryMoodSelectorDialogWidget(diary: diary);
      },
    );
  }
}

class _DiaryMoodSelectorDialogWidget extends StatefulWidget {
  /// 自定义组件
  const _DiaryMoodSelectorDialogWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<_DiaryMoodSelectorDialogWidget> createState() =>
      _DiaryMoodSelectorDialogWidgetState();
}

class _DiaryMoodSelectorDialogWidgetState
    extends State<_DiaryMoodSelectorDialogWidget> {
  List<Widget> _listAllMood() {
    List<Widget> buttonList = [];
    DiaryConstance.moodMap.forEach(
      (key, value) => buttonList.add(
        Consumer<DiaryEditorModel>(
          builder: (context, diaryEditorModel, child) {
            return IconButton(
              onPressed: () {
                diaryEditorModel.changeMood(key);
                Navigator.of(context).pop();
              },
              icon: Column(
                children: [Icon(value), Text(key)],
              ),
              color: diaryEditorModel.diary.mood != key
                  ? null
                  : Theme.of(context).brightness == Brightness.dark
                      ? darkColorScheme.primary
                      : lightColorScheme.primary,
            );
          },
        ),
      ),
    );
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('现在心情如何'),
          Text(
            'ねぇ、今どんな気持ち',
            style: TextStyle(
              fontSize: 10,
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.white54
                  : Colors.black54,
            ),
          ),
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Wrap(
              spacing: 16,
              direction: Axis.horizontal,
              children: _listAllMood(),
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          onPressed: () {
            Vibration.vibrate(duration: 50, amplitude: 255);
            Navigator.of(context).pop();
          },
          child: const Text('返回'),
        ),
      ],
    );
  }
}
