import 'package:mercurius/index.dart';

class DiaryEditorToolbarMoodButtonWidget extends QuillCustomButton {
  const DiaryEditorToolbarMoodButtonWidget({
    required super.tooltip,
    required this.currentDiary,
    required this.context,
    required this.handleToolbarChangeDiary,
  });

  final BuildContext context;
  final Diary currentDiary;
  final ValueChanged<Diary?> handleToolbarChangeDiary;

  @override
  IconData? get icon => Icons.mood;

  @override
  VoidCallback? get onTap => () async {
        Diary? newDiary = await showDialog<Diary>(
          context: context,
          builder: (context) => DiaryMoodSelectorWidget(
            diary: currentDiary,
          ),
        );
        handleToolbarChangeDiary(newDiary);
      };
}
