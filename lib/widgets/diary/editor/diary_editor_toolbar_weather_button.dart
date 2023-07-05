import 'package:mercurius/index.dart';

class DiaryEditorToolbarWeatherButtonWidget extends QuillCustomButton {
  const DiaryEditorToolbarWeatherButtonWidget({
    required super.tooltip,
    required this.currentDiary,
    required this.context,
    required this.handleToolbarChangeDiary,
  });

  final BuildContext context;
  final Diary currentDiary;
  final ValueChanged<Diary?> handleToolbarChangeDiary;

  @override
  IconData get icon => Icons.cloud;

  @override
  VoidCallback get onTap => () async {
        Diary? newDiary = await showDialog<Diary>(
          context: context,
          builder: (context) => DiaryWeatherSelectorDialogWidget(
            diary: currentDiary,
          ),
        );
        handleToolbarChangeDiary(newDiary);
      };
}
