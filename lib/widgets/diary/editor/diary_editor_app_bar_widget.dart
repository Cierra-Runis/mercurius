import 'package:mercurius/index.dart';

class DiaryEditorAppBarWidget extends ConsumerWidget
    implements PreferredSizeWidget {
  const DiaryEditorAppBarWidget({
    super.key,
    required this.diary,
    required this.quillController,
    required this.textEditingController,
    required this.handleChangeDiary,
    this.toolbarHeight,
    this.bottom,
  });

  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;

  final Diary diary;
  final QuillController quillController;
  final TextEditingController textEditingController;
  final ValueChanged<Diary?> handleChangeDiary;

  @override
  Size get preferredSize => Size.fromHeight(
        (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S localizations = S.of(context);

    return AppBar(
      leading: TextButton(
        onPressed: () {
          Mercurius.vibration(ref: ref);
          Navigator.of(context).pop();
        },
        child: Text(localizations.back),
      ),
      title: TextField(
        textAlign: TextAlign.center,
        key: GlobalKey<FormState>(),
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: localizations.untitled,
          border: InputBorder.none,
        ),
      ),
      centerTitle: true,
      actions: [
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
