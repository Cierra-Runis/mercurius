import 'package:mercurius/index.dart';

class EditorPage extends StatefulHookWidget {
  const EditorPage({
    super.key,
    required this.diary,
    this.autoSave = false,
  });

  final Diary diary;
  final bool autoSave;

  @override
  State<EditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends State<EditorPage> {
  late final QuillController _quillController;
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
    final textEditingController = useTextEditingController(
      text: _diary.titleString,
    );

    return Scaffold(
      appBar: EditorAppBar(
        diary: _diary,
        quillController: _quillController,
        textEditingController: textEditingController,
        handleChangeDiary: _handleChangeDiary,
        handleAutoSaveButtonChangeState: _handleAutoSaveButtonChangeState,
        autoSave: _autoSave,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: QuillProvider(
          configurations: QuillConfigurations(
            controller: _quillController,
            sharedConfigurations: QuillSharedConfigurations(
              locale: Localizations.localeOf(context),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: EditorBody(
                  readOnly: false,
                  scrollController: _scrollController,
                ),
              ),
              const Divider(),
              EditorToolbarWidget(
                diary: _diary,
                scrollController: _scrollController,
                handleChangeDiary: _handleChangeDiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
