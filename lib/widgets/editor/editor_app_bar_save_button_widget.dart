import 'package:mercurius/index.dart';

class EditorAppBarSaveButtonWidget extends ConsumerWidget {
  const EditorAppBarSaveButtonWidget({
    super.key,
    required this.diary,
    required this.quillController,
    required this.handleChangeDiary,
    required this.textEditingController,
  });

  final Diary diary;
  final QuillController quillController;
  final ValueChanged<Diary?> handleChangeDiary;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return TextButton(
      onPressed: () {
        final plainText = quillController.document
            .toPlainText()
            .replaceAll(RegExp(r'\n'), '');
        if (plainText == '') {
          App.vibration();
          Flushbar(
            icon: const Icon(UniconsLine.confused),
            isDismissible: false,
            messageText: Center(
              child: Text(
                l10n.contentCannotBeEmpty,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            margin: const EdgeInsets.fromLTRB(60, 16, 60, 0),
            barBlur: 1.0,
            borderRadius: BorderRadius.circular(16),
            backgroundColor: context.colorScheme.outline.withAlpha(16),
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
          final newDiary = Diary.copyWith(
            diary,
            contentJsonString: jsonEncode(
              quillController.document.toDelta().toJson(),
            ),
            latestEditTime: DateTime.now(),
            titleString: textEditingController.text,
            editing: false,
          );
          handleChangeDiary(newDiary);
          isarService.saveDiary(newDiary);
          context.pop(newDiary);
        }
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(56, 56),
        ),
      ),
      child: Text(l10n.save),
    );
  }
}
