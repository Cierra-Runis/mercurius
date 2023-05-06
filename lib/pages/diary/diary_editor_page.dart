import 'package:mercurius/index.dart';

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
  late final QuillController _controller;
  final TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  late Diary _diary;

  @override
  void initState() {
    super.initState();
    setState(() {
      _diary = widget.diary;
    });
    _controller = QuillController(
      document: _diary.contentJsonString != null
          ? Document.fromJson(
              jsonDecode(_diary.contentJsonString!),
            )
          : Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
    _title.text = _diary.titleString ?? '';
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  void _handleChangeDiary(Diary? newDiary) {
    setState(() {
      _diary = newDiary ?? _diary;
    });
  }

  /// TIPS: 遮挡问题 https://github.com/singerdmx/flutter-quill/issues/1017
  /// TIPS: 选至末尾问题 https://github.com/singerdmx/flutter-quill/issues/1098
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            MercuriusKit.vibration();
            Navigator.of(context).pop();
          },
          child: const Text('取消'),
        ),
        title: TextField(
          textAlign: TextAlign.center,
          key: _formKey,
          controller: _title,
          decoration: const InputDecoration(
            hintText: '无标题',
            border: InputBorder.none,
          ),
        ),
        centerTitle: true,
        actions: [
          DiaryEditorAppBarSaveButtonWidget(
            currentDiary: _diary,
            controller: _controller,
            handleAppBarChangeDiary: _handleChangeDiary,
            title: _title,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: DiaryEditorBodyWidget(
                readOnly: false,
                scrollController: _scrollController,
                controller: _controller,
              ),
            ),
            const Divider(),
            DiaryEditorToolbarWidget(
              currentDiary: _diary,
              scrollController: _scrollController,
              controller: _controller,
              handleToolbarChangeDiary: _handleChangeDiary,
            ),
          ],
        ),
      ),
    );
  }
}
