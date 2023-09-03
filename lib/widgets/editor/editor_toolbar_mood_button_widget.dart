import 'package:mercurius/index.dart';

class EditorToolbarMoodButtonWidget extends QuillCustomButton {
  const EditorToolbarMoodButtonWidget({
    required super.tooltip,
    required this.currentDiary,
    required this.context,
    required this.handleToolbarChangeDiary,
  });

  final BuildContext context;
  final Diary currentDiary;
  final ValueChanged<Diary?> handleToolbarChangeDiary;

  @override
  IconData get icon => Icons.mood_rounded;

  @override
  VoidCallback get onTap => () async {
        Diary? newDiary = await showDialog<Diary>(
          context: context,
          builder: (context) => MoodSelectorWidget(
            diary: currentDiary,
          ),
        );
        handleToolbarChangeDiary(newDiary);
      };
}
