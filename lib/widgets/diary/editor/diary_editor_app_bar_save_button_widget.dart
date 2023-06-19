import 'package:mercurius/index.dart';

class DiaryEditorAppBarSaveButtonWidget extends ConsumerWidget {
  const DiaryEditorAppBarSaveButtonWidget({
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
    final S localizations = S.of(context);

    return TextButton(
      onPressed: () {
        String plainText = quillController.document
            .toPlainText()
            .replaceAll(RegExp(r'\n'), '');
        if (plainText == '') {
          Mercurius.vibration(ref: ref, duration: 300);
          Flushbar(
            icon: const Icon(UniconsLine.confused),
            isDismissible: false,
            messageText: Center(
              child: Text(
                localizations.contentCannotBeEmpty,
                style: const TextStyle(
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
            diary,
            contentJsonString: jsonEncode(
              quillController.document.toDelta().toJson(),
            ),
            latestEditTime: DateTime.now(),
            titleString: textEditingController.text,
          );
          handleChangeDiary(newDiary);
          isarService.saveDiary(newDiary);
          Navigator.of(context).pop(newDiary);
        }
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(56, 56),
        ),
      ),
      child: Text(localizations.save),
    );
  }
}
