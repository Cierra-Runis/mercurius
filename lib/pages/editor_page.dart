import 'package:mercurius/index.dart';

class EditorPage extends ConsumerStatefulWidget {
  const EditorPage({
    super.key,
    required this.diary,
    this.autoSave = false,
  });

  final Diary diary;
  final bool autoSave;

  @override
  ConsumerState<EditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends ConsumerState<EditorPage> {
  late final QuillController _quillController;
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late Diary _diary;
  late bool _autoSave;

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _autoSave = widget.autoSave;
    _quillController = QuillController(
      document: _diary.document,
      keepStyleOnNewLine: true,
      selection: const TextSelection.collapsed(offset: 0),
    );
    _textEditingController.text = _diary.titleString;
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  void _handleChangeDiary(Diary? newDiary) {
    setState(() => _diary = newDiary ?? _diary);
  }

  void _handleAutoSaveButtonChangeState(bool newState) {
    setState(() => _autoSave = newState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EditorAppBarWidget(
        diary: _diary,
        quillController: _quillController,
        textEditingController: _textEditingController,
        handleChangeDiary: _handleChangeDiary,
        handleAutoSaveButtonChangeState: _handleAutoSaveButtonChangeState,
        autoSave: _autoSave,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: EditorBodyWidget(
                readOnly: false,
                scrollController: _scrollController,
                quillController: _quillController,
              ),
            ),
            const Divider(),
            EditorToolbarWidget(
              diary: _diary,
              scrollController: _scrollController,
              quillController: _quillController,
              handleChangeDiary: _handleChangeDiary,
            ),
          ],
        ),
      ),
    );
  }
}
