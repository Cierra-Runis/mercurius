import 'package:mercurius/index.dart';

class DiaryEditorToolbarTimestampButtonWidget extends QuillCustomButton {
  const DiaryEditorToolbarTimestampButtonWidget({
    required super.tooltip,
    required this.lang,
    required this.controller,
  });

  final QuillController controller;
  final String lang;

  @override
  IconData? get icon => UniconsLine.clock;

  @override
  VoidCallback? get onTap => () {
        DateTime now = DateTime.now();
        String date = now.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang);
        String time = now.format(DateFormat.HOUR24_MINUTE_SECOND, lang);
        String dateTimeString = '[$date $time]\n';
        int extentOffset = controller.selection.extentOffset;
        controller.document.insert(
          extentOffset,
          dateTimeString,
        );
        controller.updateSelection(
          TextSelection.collapsed(
            offset: extentOffset + dateTimeString.length,
          ),
          ChangeSource.LOCAL,
        );
      };
}
