import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryEditorModel extends ChangeNotifier {
  late Diary diary;

  void init(Diary diary) {
    this.diary = diary;
  }

  void changeMood(String mood) {
    diary.mood = mood;
    notifyListeners();
    super.notifyListeners();
  }
}

Map<String, IconData> _moodMap = {
  '开心': UniconsLine.smile,
  '一般': UniconsLine.meh_closed_eye,
  '生气': UniconsLine.angry,
  '困惑': UniconsLine.confused,
  '失落': UniconsLine.frown,
  '大笑': UniconsLine.laughing,
  '难受': UniconsLine.silent_squint,
  '大哭': UniconsLine.sad_crying,
  '我死': UniconsLine.smile_dizzy,
};

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
  final isarService = IsarService();
  final TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = flutter_quill.QuillController(
      document: widget.diary.contentJsonString != null
          ? flutter_quill.Document.fromJson(
              jsonDecode(widget.diary.contentJsonString!),
            )
          : flutter_quill.Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _title.text = widget.diary.titleString ?? '';
    diaryEditorModel.init(widget.diary);
    super.initState();
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  // TODO: 修复遮挡问题
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
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
              DevTools.printLog(
                jsonEncode(_controller.document.toDelta().toJson()),
              );
              diaryEditorModel.diary.contentJsonString =
                  jsonEncode(_controller.document.toDelta().toJson());
              isarService.saveDiary(
                diaryEditorModel.diary
                  ..latestEditTime = DateTime.now().toString()
                  ..titleString = (_title.text == '' ? null : _title.text),
              );
              Navigator.of(context).pop();
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
                locale: const Locale('zh', 'hk'),
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                scrollable: true,
                expands: false,
                padding: const EdgeInsets.all(2.0),
                autoFocus: true,
                placeholder: '记些什么吧',
                controller: _controller,
                readOnly: false,
                scrollBottomInset: 10,
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
                    // TODO: 插入时间
                  },
                ),
                flutter_quill.QuillCustomButton(
                  icon: Icons.mood,
                  onTap: () =>
                      _selectDiaryMoodDialog(context, diaryEditorModel.diary),
                ),
              ],
              locale: const Locale('zh', 'hk'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _selectDiaryMoodDialog(BuildContext context, Diary diary) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return DiaryMoodSelectorDialogWidget(diary: diary);
    },
  );
}

class DiaryMoodSelectorDialogWidget extends StatefulWidget {
  // 自定义组件
  const DiaryMoodSelectorDialogWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryMoodSelectorDialogWidget> createState() =>
      _DiaryMoodSelectorDialogWidgetState();
}

class _DiaryMoodSelectorDialogWidgetState
    extends State<DiaryMoodSelectorDialogWidget> {
  List<Widget> _listAllMood() {
    List<Widget> buttonList = List<Widget>.from([]);
    _moodMap.forEach(
      (key, value) {
        buttonList.add(
          Consumer<DiaryEditorModel>(
            builder: (context, diaryEditorModel, child) {
              return IconButton(
                onPressed: () {
                  diaryEditorModel.changeMood(key);
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
        );
      },
    );
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            Navigator.of(context).pop();
          },
          child: const Text('返回'),
        ),
      ],
    );
  }
}
