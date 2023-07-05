import 'package:mercurius/index.dart';

class DiaryEditorAppBarWidget extends ConsumerWidget
    implements PreferredSizeWidget {
  const DiaryEditorAppBarWidget({
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
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return AppBar(
      leading: TextButton(
        onPressed: () {
          Mercurius.vibration(ref: ref);
          Navigator.of(context).pop();
        },
        child: Text(l10n.back),
      ),
      title: Stack(
        children: [
          TextField(
            textAlign: TextAlign.center,
            key: GlobalKey<FormState>(),
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: l10n.untitled,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        DiaryEditorAutoSaveButton(
          diary: diary,
          quillController: quillController,
          textEditingController: textEditingController,
          autoSave: autoSave,
          handleAutoSaveButtonChangeState: handleAutoSaveButtonChangeState,
        ),
        DiaryEditorAppBarSaveButtonWidget(
          diary: diary,
          quillController: quillController,
          handleChangeDiary: handleChangeDiary,
          textEditingController: textEditingController,
        ),
      ],
    );
  }
}
