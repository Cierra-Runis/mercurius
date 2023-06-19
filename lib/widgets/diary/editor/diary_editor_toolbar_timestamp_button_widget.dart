import 'package:mercurius/index.dart';

class DiaryEditorToolbarTimestampButtonWidget extends QuillCustomButton {
  const DiaryEditorToolbarTimestampButtonWidget({
    required super.tooltip,
    required this.controller,
  });

  final QuillController controller;

  @override
  IconData? get icon => UniconsLine.clock;

  @override
  VoidCallback? get onTap => () {
        String dateTimeString = '[${DateTime.now().toHumanString()}]\n';
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
