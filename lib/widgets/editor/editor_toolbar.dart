import 'package:mercurius/index.dart';

class EditorToolbarWidget extends ConsumerWidget {
  const EditorToolbarWidget({
    super.key,
    required this.diary,
    required this.scrollController,
    required this.handleChangeDiary,
  });

  final Diary diary;
  final ScrollController scrollController;
  final ValueChanged<Diary?> handleChangeDiary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconSelectedFillColor = context.brightness.isDark
        ? context.colorScheme.outlineVariant
        : context.colorScheme.primaryContainer;

    final quillIconTheme = QuillIconTheme(
      borderRadius: 10,
      iconSelectedFillColor: iconSelectedFillColor,
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
            options: EditorToolbarImageButton(
              tooltip: l10n.insertImage,
              iconTheme: quillIconTheme,
              controller: controller,
              onPressed: () => EditorToolbarImageButton.onTap(
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
          options: EditorToolbarTagButton(
            tooltip: l10n.insertTag,
            iconTheme: quillIconTheme,
            controller: controller,
            onPressed: () => EditorToolbarTagButton.onTap(controller, context),
          ),
        );
      }
    ];

    final editorMoodButton = QuillToolbarCustomButtonOptions(
      tooltip: l10n.changeMood,
      icon: const Icon(
        Icons.mood_rounded,
        size: kDefaultIconSize,
      ),
      onPressed: () => changMood(context, diary),
    );
    final editorWeather = QuillToolbarCustomButtonOptions(
      tooltip: l10n.changeWeather,
      icon: const Icon(
        Icons.cloud,
        size: kDefaultIconSize,
      ),
      onPressed: () => changeWeather(context, diary),
    );
    final editorDateButton = QuillToolbarCustomButtonOptions(
      tooltip: l10n.changeDate,
      iconTheme: quillIconTheme,
      icon: const Icon(
        Icons.date_range_rounded,
        size: kDefaultIconSize,
      ),
      onPressed: () => changeDate(context, diary),
    );
    return QuillToolbar(
      configurations: QuillToolbarConfigurations(
        buttonOptions: QuillToolbarButtonOptions(
          base: QuillToolbarBaseButtonOptions(
            iconTheme: quillIconTheme,
            globalIconSize: 16,
          ),
        ),
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
        toolbarSectionSpacing: 2,
        embedButtons: embedButtons,
        customButtons: [
          editorMoodButton,
          editorWeather,
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
