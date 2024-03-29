import 'package:mercurius/index.dart';

class EditorAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const EditorAppBar({
    super.key,
    required this.diary,
    required this.quillController,
    required this.textEditingController,
    required this.handleChangeDiary,
    required this.handleAutoSaveButtonChangeState,
    this.autoSave = false,
    this.toolbarHeight,
    this.bottom,
  });

  final bool autoSave;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;

  final Diary diary;
  final QuillController quillController;
  final TextEditingController textEditingController;
  final ValueChanged<Diary?> handleChangeDiary;
  final ValueChanged<bool> handleAutoSaveButtonChangeState;

  @override
  Size get preferredSize => Size.fromHeight(
        (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return AppBar(
      title: TextField(
        textAlign: TextAlign.center,
        key: GlobalKey<FormState>(),
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: l10n.untitled,
          border: InputBorder.none,
        ),
      ),
      actions: [
        EditorAutoSaveButton(
          diary: diary,
          quillController: quillController,
          textEditingController: textEditingController,
          autoSave: autoSave,
          handleAutoSaveButtonChangeState: handleAutoSaveButtonChangeState,
        ),
        EditorSaveButton(
          diary: diary,
          quillController: quillController,
          handleChangeDiary: handleChangeDiary,
          textEditingController: textEditingController,
        ),
      ],
    );
  }
}
