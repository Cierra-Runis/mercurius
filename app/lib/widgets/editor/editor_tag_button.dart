import 'package:mercurius/index.dart';

class EditorTagButton extends QuillToolbarCustomButtonOptions {
  const EditorTagButton({
    required super.tooltip,
    super.iconTheme,
    super.icon = const Icon(
      Icons.new_label_rounded,
    ),
    required super.onPressed,
  });

  static void onTap(
    QuillController controller,
    BuildContext context,
  ) async {
    final lang = Localizations.localeOf(context).toLanguageTag();

    final now = DateTime.now();
    final time = now.format(DateFormat.HOUR24_MINUTE_SECOND, lang);

    final diaryTag = await showDialog<DiaryTag>(
      context: context,
      builder: (context) => TagSelector(
        defaultMessage: time,
      ),
    );
    if (diaryTag != null) _insert(controller, diaryTag);
  }

  static void _insert(
    QuillController controller,
    DiaryTag diaryTag,
  ) {
    controller.document.insert(
      controller.selection.extentOffset,
      TagBlockEmbed(json: diaryTag.toJson()),
    );

    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.local,
    );

    controller.document.insert(controller.selection.extentOffset, ' \n');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 2,
      ),
      ChangeSource.local,
    );
  }
}
