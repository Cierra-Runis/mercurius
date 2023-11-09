import 'package:mercurius/index.dart';

class EditorToolbarMoodButtonWidget extends QuillCustomButton {
  const EditorToolbarMoodButtonWidget({
    required super.tooltip,
    super.iconData = Icons.mood_rounded,
    required this.currentDiary,
    required this.context,
    required this.handleToolbarChangeDiary,
  });

  final BuildContext context;
  final Diary currentDiary;
  final ValueChanged<Diary?> handleToolbarChangeDiary;

  @override
  VoidCallback get onTap => () async {
        final newDiary = await showDialog<Diary>(
          context: context,
          builder: (context) => MoodSelector(
            diary: currentDiary,
          ),
        );
        handleToolbarChangeDiary(newDiary);
      };
}
