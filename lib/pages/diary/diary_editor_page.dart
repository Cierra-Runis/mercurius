import 'package:mercurius/index.dart';

class DiaryEditorPage extends ConsumerStatefulWidget {
  const DiaryEditorPage({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  ConsumerState<DiaryEditorPage> createState() => _DiaryEditorPageState();
}

class _DiaryEditorPageState extends ConsumerState<DiaryEditorPage> {
  late final QuillController _quillController;
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late Diary _diary;

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _quillController = QuillController(
      document: _diary.document,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DiaryEditorAppBarWidget(
        diary: _diary,
        quillController: _quillController,
        textEditingController: _textEditingController,
        handleChangeDiary: _handleChangeDiary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: DiaryEditorBodyWidget(
                readOnly: false,
                scrollController: _scrollController,
                quillController: _quillController,
              ),
            ),
            const Divider(),
            DiaryEditorToolbarWidget(
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
