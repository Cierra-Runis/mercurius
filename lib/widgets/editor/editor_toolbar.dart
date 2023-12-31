import 'package:mercurius/index.dart';

class EditorToolbar extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    const quillIconTheme = QuillIconTheme(
      iconButtonSelectedData: IconButtonData(
        iconSize: 14,
        constraints: BoxConstraints(),
      ),
      iconButtonUnselectedData: IconButtonData(
        iconSize: 14,
        constraints: BoxConstraints(),
      ),
    );

    final path = ref.watch(mercuriusPathProvider);

    final l10n = L10N.maybeOf(context) ?? L10N.current;

    final embedButtons = <EmbedButtonBuilder>[
      (controller, _, __, ___) {
        return path.when(
          loading: () => const Loading(),
          error: (error, stackTrace) => const SizedBox(),
          data: (data) => QuillToolbarCustomButton(
            controller: controller,
            options: EditorImageButton(
              tooltip: l10n.insertImage,
              onPressed: () => EditorImageButton.onTap(
                controller,
                context,
                data,
              ),
            ),
          ),
        );
      },
      (controller, _, __, ___) {
        return QuillToolbarCustomButton(
          controller: controller,
          options: EditorTagButton(
            tooltip: l10n.insertTag,
            onPressed: () => EditorTagButton.onTap(controller, context),
          ),
        );
      }
    ];

    final editorMoodButton = QuillToolbarCustomButtonOptions(
      tooltip: l10n.changeMood,
      icon: const Icon(
        Icons.mood_rounded,
      ),
      onPressed: () => changMood(context, diary),
    );
    final editorWeatherButton = QuillToolbarCustomButtonOptions(
      tooltip: l10n.changeWeather,
      icon: const Icon(
        Icons.cloud,
      ),
      onPressed: () => changeWeather(context, diary),
    );
    final editorDateButton = QuillToolbarCustomButtonOptions(
      tooltip: l10n.changeDate,
      icon: const Icon(
        Icons.date_range_rounded,
      ),
      onPressed: () => changeDate(context, diary),
    );

    return QuillToolbar.simple(
      configurations: QuillSimpleToolbarConfigurations(
        buttonOptions: const QuillSimpleToolbarButtonOptions(
          base: QuillToolbarBaseButtonOptions(
            iconButtonFactor: 1,
            iconSize: 14,
            iconTheme: quillIconTheme,
          ),
        ),
        controller: controller,
        showUndo: false,
        showRedo: false,
        showFontFamily: false,
        showFontSize: false,
        showBackgroundColorButton: false,
        showClearFormat: false,
        showColorButton: false,
        showInlineCode: false,
        showAlignmentButtons: true,
        showJustifyAlignment: false,
        showDividers: false,
        showSmallButton: true,
        showSearchButton: false,
        showIndent: false,
        showLink: false,
        showSubscript: false,
        showSuperscript: false,
        toolbarSectionSpacing: -10,
        embedButtons: embedButtons,
        customButtons: [
          editorMoodButton,
          editorWeatherButton,
          editorDateButton,
        ],
      ),
    );
  }

  void changMood(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryMoodType?>(
      MoodSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(diary.copyWith(moodType: type));
  }

  void changeWeather(BuildContext context, Diary diary) async {
    final type = await context.pushDialog<DiaryWeatherType>(
      WeatherSelector(
        diary: diary,
      ),
    );
    handleChangeDiary(diary.copyWith(weatherType: type));
  }

  void changeDate(BuildContext context, Diary diary) async {
    final dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      useRootNavigator: false,
      initialDate: diary.createDateTime,
      firstDate: DateTime(1949, 10, 1),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );
    if (dateTime != null) {
      handleChangeDiary(
        diary.copyWith(createDateTime: dateTime),
      );
    }
  }
}
