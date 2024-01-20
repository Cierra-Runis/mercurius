import 'package:mercurius/index.dart';

class EditorToolbar extends StatelessWidget {
  const EditorToolbar({
    super.key,
    required this.diary,
    required this.controller,
    required this.scrollController,
    required this.handleChangeDiary,
  });

  final Diary diary;
  final QuillController controller;
  final ScrollController scrollController;
  final ValueChanged<Diary?> handleChangeDiary;

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.bold,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.italic,
        ),
        // const _ToggleButton(),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.underline,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.strikeThrough,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.small,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.leftAlignment,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.centerAlignment,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.rightAlignment,
        ),
        // QuillToolbarSelectHeaderStyleDropdownButton(
        //   controller: controller,
        // ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.list,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.ul,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.codeBlock,
        ),
        QuillToolbarToggleStyleButton(
          controller: controller,
          attribute: Attribute.blockQuote,
        ),
        // QuillToolbarSelectHeaderStyleButtons(
        //   controller: controller,
        // ),
        IconButton(
          tooltip: l10n.insertImage,
          onPressed: () => EditorImageButton.onTap(controller, context),
          icon: const Icon(Icons.add_photo_alternate_rounded),
        ),
        IconButton(
          tooltip: l10n.insertTag,
          onPressed: () => EditorTagButton.onTap(controller, context),
          icon: const Icon(Icons.new_label_rounded),
        ),
        IconButton(
          tooltip: l10n.changeMood,
          onPressed: () => changMood(context, diary),
          icon: const Icon(Icons.mood_rounded),
        ),
        IconButton(
          tooltip: l10n.changeWeather,
          onPressed: () => changeWeather(context, diary),
          icon: const Icon(Icons.cloud_rounded),
        ),
        IconButton(
          tooltip: l10n.changeDate,
          onPressed: () => changeDate(context, diary),
          icon: const Icon(Icons.calendar_month_rounded),
        ),
      ]
          .map(
            (e) => Transform.scale(
              scale: 0.8,
              child: e,
            ),
          )
          .toList(),
    );
  }

  void changMood(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryMoodType?>(
      MoodSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(diary.copyWith(moodType: type ?? diary.moodType));
  }

  void changeWeather(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryWeatherType>(
      WeatherSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(diary.copyWith(weatherType: type ?? diary.weatherType));
  }

  void changeDate(BuildContext context, Diary diary) async {
    final dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      initialDate: diary.createAt,
      firstDate: DateTime(1949, 10),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );
    if (dateTime != null) {
      handleChangeDiary(
        diary.copyWith(createAt: dateTime),
      );
    }
  }
}

// class _ToggleButton extends StatefulWidget {
//   const _ToggleButton();

//   @override
//   State<_ToggleButton> createState() => _ToggleButtonState();
// }

// class _ToggleButtonState extends State<_ToggleButton> {
//   bool isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSwitcher(
//       duration: Durations.medium2,
//       child: IconButton.filledTonal(
//         key: UniqueKey(),
//         isSelected: isSelected,
//         onPressed: () => setState(() => isSelected = !isSelected),
//         icon: const Icon(
//           Icons.format_bold_rounded,
//         ),
//       ),
//     );
//   }
// }
