import 'package:mercurius/index.dart';

class DiaryEditorAutoSaveButton extends StatefulWidget {
  const DiaryEditorAutoSaveButton({
    super.key,
    required this.diary,
    required this.quillController,
    required this.textEditingController,
    this.autoSave = false,
  });

  final Diary diary;
  final bool autoSave;
  final QuillController quillController;
  final TextEditingController textEditingController;

  @override
  State<DiaryEditorAutoSaveButton> createState() =>
      _DiaryEditorAutoSaveButtonState();
}

class _DiaryEditorAutoSaveButtonState extends State<DiaryEditorAutoSaveButton> {
  late Diary _diary;
  late bool _autoSave;
  late QuillController _quillController;
  late TextEditingController _textEditingController;

  late PausableTimer _timer;

  @override
  void initState() {
    super.initState();
    _diary = widget.diary;
    _autoSave = widget.autoSave;
    _quillController = widget.quillController;
    _textEditingController = widget.textEditingController;
    _timer = PausableTimer(const Duration(seconds: 5), () {
      Mercurius.printLog('自动保存 ${DateTime.now().toHumanString()}');
      _timer
        ..reset()
        ..start();
      String plainText =
          _quillController.document.toPlainText().replaceAll(RegExp(r'\n'), '');
      if (plainText != '') {
        Diary newDiary = Diary.copyWith(
          _diary,
          contentJsonString: jsonEncode(
            _quillController.document.toDelta().toJson(),
          ),
          latestEditTime: DateTime.now(),
          titleString: _textEditingController.text,
          editing: true,
        );
        isarService.saveDiary(newDiary);
      }
    });
    if (_autoSave) {
      _timer.start();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        thumbIcon: MaterialStateProperty.resolveWith<Icon>(
          (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? const Icon(Icons.timer_rounded)
              : const Icon(Icons.timer_off_rounded),
        ),
        value: _autoSave,
        onChanged: (value) => setState(
          () => (_autoSave = value) ? _timer.start() : _timer.pause(),
        ),
      ),
    );
  }
}