import 'package:mercurius/index.dart';

class DiaryEditorToolbarWidget extends ConsumerWidget {
  const DiaryEditorToolbarWidget({
    super.key,
    required this.diary,
    required this.scrollController,
    required this.quillController,
    required this.handleChangeDiary,
  });

  final Diary diary;
  final ScrollController scrollController;
  final QuillController quillController;
  final ValueChanged<Diary?> handleChangeDiary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconSelectedFillColor =
        Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.outlineVariant
            : Theme.of(context).colorScheme.primaryContainer;

    final quillIconTheme = QuillIconTheme(
      borderRadius: 12,
      iconSelectedFillColor: iconSelectedFillColor,
    );

    final path = ref.watch(mercuriusPathProvider);

    final S localizations = S.of(context);
    final String lang = Localizations.localeOf(context).toLanguageTag();

    List<EmbedButtonBuilder> embedButtons = [
      (controller, _, __, ___) {
        return path.when(
          loading: () => const MercuriusLoadingWidget(),
          error: (error, stackTrace) => Container(),
          data: (data) => DiaryEditorToolbarImageButtonWidget(
            tooltip: localizations.insertImage,
            controller: controller,
            context: context,
            path: data,
          ),
        );
      }
    ];

    return QuillToolbar.basic(
      controller: quillController,
      showUndo: false,
      showRedo: false,
      showFontFamily: false,
      showFontSize: false,
      showBackgroundColorButton: false,
      showClearFormat: false,
      showColorButton: false,
      showCodeBlock: false,
      showInlineCode: false,
      showAlignmentButtons: true,
      showListBullets: false,
      showListCheck: false,
      showListNumbers: false,
      showJustifyAlignment: false,
      showDividers: false,
      showSmallButton: true,
      showSearchButton: false,
      showIndent: false,
      showLink: false,
      showSubscript: false,
      showSuperscript: false,
      toolbarSectionSpacing: 2,
      iconTheme: quillIconTheme,
      embedButtons: embedButtons,
      customButtons: [
        DiaryEditorToolbarTimestampButtonWidget(
          controller: quillController,
          tooltip: localizations.insertTime,
          lang: lang,
        ),
        DiaryEditorToolbarMoodButtonWidget(
          context: context,
          currentDiary: diary,
          handleToolbarChangeDiary: handleChangeDiary,
          tooltip: localizations.changeMood,
        ),
        DiaryEditorToolbarWeatherButtonWidget(
          context: context,
          currentDiary: diary,
          handleToolbarChangeDiary: handleChangeDiary,
          tooltip: localizations.changeWeather,
        ),
        DiaryEditorToolbarDateTimeButtonWidget(
          currentDiary: diary,
          context: context,
          handleToolbarChangeDiary: handleChangeDiary,
          tooltip: localizations.changeDate,
        ),
      ],
      locale: Localizations.localeOf(context),
    );
  }
}
