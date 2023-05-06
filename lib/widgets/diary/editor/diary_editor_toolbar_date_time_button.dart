import 'package:mercurius/index.dart';

class DiaryEditorToolbarDateTimeButtonWidget extends QuillCustomButton {
  const DiaryEditorToolbarDateTimeButtonWidget({
    required this.currentDiary,
    required this.context,
    required this.handleToolbarChangeDiary,
  });

  final BuildContext context;
  final Diary currentDiary;
  final ValueChanged<Diary?> handleToolbarChangeDiary;

  @override
  IconData? get icon => Icons.date_range_rounded;

  @override
  VoidCallback? get onTap => () async {
        DateTime? dateTime = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: currentDiary.createDateTime,
          firstDate: DateTime(1949, 10, 1),
          lastDate: DateTime.now().add(
            const Duration(days: 20000),
          ),
        );
        if (dateTime != null) {
          handleToolbarChangeDiary(
            Diary.copyWith(
              currentDiary,
              createDateTime: dateTime,
            ),
          );
        }
      };
}
