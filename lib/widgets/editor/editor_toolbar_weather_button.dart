import 'package:mercurius/index.dart';

class EditorToolbarWeatherButtonWidget extends QuillCustomButton {
  const EditorToolbarWeatherButtonWidget({
    required super.tooltip,
    super.iconData = Icons.cloud,
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
          builder: (context) => WeatherSelector(
            diary: currentDiary,
          ),
        );
        handleToolbarChangeDiary(newDiary);
      };
}
