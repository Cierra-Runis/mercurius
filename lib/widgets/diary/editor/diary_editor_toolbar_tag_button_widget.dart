import 'package:mercurius/index.dart';

class DiaryEditorToolbarTagButtonWidget extends CustomButton {
  DiaryEditorToolbarTagButtonWidget({
    super.key,
    super.icon = Icons.new_label_rounded,
    super.iconTheme,
    required super.tooltip,
    required this.controller,
    required this.context,
  }) : super(onPressed: () => _onPressed(controller, context));

  final BuildContext context;
  final QuillController controller;

  static void _onPressed(
    QuillController controller,
    BuildContext context,
  ) async {
    final String lang = Localizations.localeOf(context).toLanguageTag();

    DateTime now = DateTime.now();
    String date = now.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang);
    String time = now.format(DateFormat.HOUR24_MINUTE_SECOND, lang);
    String dateTimeString = '$date $time';

    DiaryTag? diaryTag = await showDialog(
      context: context,
      builder: (context) => DiaryTagSelectorWidget(
        defaultMessage: dateTimeString,
      ),
    );
    if (diaryTag != null) _insertImage(controller, diaryTag);
  }

  static void _insertImage(
    QuillController controller,
    DiaryTag diaryTag,
  ) {
    controller.document.insert(
      controller.selection.extentOffset,
      DiaryTagBlockEmbed(jsonEncode(diaryTag.toJson())),
    );

    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.LOCAL,
    );

    controller.document.insert(controller.selection.extentOffset, ' ');
    controller.updateSelection(
      TextSelection.collapsed(
        offset: controller.selection.extentOffset + 1,
      ),
      ChangeSource.LOCAL,
    );
  }
}
