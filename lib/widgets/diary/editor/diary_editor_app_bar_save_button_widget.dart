import 'package:mercurius/index.dart';

class DiaryEditorAppBarSaveButtonWidget extends ConsumerWidget {
  const DiaryEditorAppBarSaveButtonWidget({
    super.key,
    required this.currentDiary,
    required this.controller,
    required this.handleAppBarChangeDiary,
    required this.title,
  });

  final Diary currentDiary;
  final QuillController controller;
  final ValueChanged<Diary?> handleAppBarChangeDiary;
  final TextEditingController title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        String plainText = controller.document
            .toPlainText()
            .replaceAll(RegExp(r'\n'), '')
            .replaceAll(RegExp(r' '), '');
        if (plainText == '') {
          Mercurius.vibration(ref: ref, duration: 300);
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
                Theme.of(context).colorScheme.outline.withAlpha(16),
            boxShadows: const [
              BoxShadow(
                color: Colors.transparent,
                offset: Offset(0, 16),
              ),
            ],
            duration: const Duration(
              milliseconds: 600,
            ),
            flushbarPosition: FlushbarPosition.TOP,
          ).show(context);
        } else {
          Mercurius.vibration(ref: ref);
          Diary newDiary = Diary.copyWith(
            currentDiary,
            contentJsonString: jsonEncode(
              controller.document.toDelta().toJson(),
            ),
            latestEditTime: DateTime.now(),
            titleString: title.text,
          );
          handleAppBarChangeDiary(newDiary);
          isarService.saveDiary(newDiary);
          Navigator.of(context).pop(newDiary);
        }
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(56, 56),
        ),
      ),
      child: const Text('保存'),
    );
  }
}