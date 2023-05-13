import 'package:mercurius/index.dart';

class DiaryEditorAppBarSaveButtonWidget extends ConsumerWidget {
  const DiaryEditorAppBarSaveButtonWidget({
    Key? key,
    required this.currentDiary,
    required this.controller,
    required this.handleAppBarChangeDiary,
    required this.title,
  }) : super(key: key);

  final Diary currentDiary;
  final QuillController controller;
  final ValueChanged<Diary?> handleAppBarChangeDiary;
  final TextEditingController title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        String plainText = jsonEncode(
          controller.document
              .toPlainText()
              .replaceAll(RegExp(r'\n'), '')
              .replaceAll(RegExp(r' '), ''),
        );
        if (plainText != '""') {
          MercuriusKit.vibration(ref: ref);
          Diary newDiary = Diary.copyWith(
            currentDiary,
            contentJsonString: jsonEncode(
              controller.document.toDelta().toJson(),
            ),
            latestEditTime: DateTime.now(),
            titleString: title.text == '' ? null : title.text,
          );
          handleAppBarChangeDiary(newDiary);
          ref.watch(isarServiceProvider.notifier).saveDiary(newDiary);
          Navigator.of(context).pop(newDiary);
        } else {
          MercuriusKit.vibration(ref: ref, duration: 300);
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
