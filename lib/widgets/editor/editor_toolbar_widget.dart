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
      borderRadius: 12,
      iconSelectedFillColor: iconSelectedFillColor,
    );

    final path = ref.watch(mercuriusPathProvider);

    final l10n = context.l10n;

    final embedButtons = <EmbedButtonBuilder>[
      (controller, _, __, ___) {
        return path.when(
          loading: () => const Loading(),
          error: (error, stackTrace) => const SizedBox(),
          data: (data) => EditorToolbarImageButtonWidget(
            tooltip: l10n.insertImage,
            iconTheme: quillIconTheme,
            controller: controller,
            context: context,
            path: data,
          ),
        );
      },
      (controller, _, __, ___) {
        return EditorToolbarTagButtonWidget(
          tooltip: l10n.insertTag,
          iconTheme: quillIconTheme,
          controller: controller,
          context: context,
        );
      }
    ];

    return QuillToolbar(
      configurations: QuillToolbarConfigurations(
        buttonOptions: QuillToolbarButtonOptions(
          base: QuillToolbarBaseButtonOptions(iconTheme: quillIconTheme),
        ),
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
        embedButtons: embedButtons,
        customButtons: [
          EditorToolbarMoodButtonWidget(
            context: context,
            currentDiary: diary,
            handleToolbarChangeDiary: handleChangeDiary,
            tooltip: l10n.changeMood,
          ),
          EditorToolbarWeatherButtonWidget(
            context: context,
            currentDiary: diary,
            handleToolbarChangeDiary: handleChangeDiary,
            tooltip: l10n.changeWeather,
          ),
          EditorToolbarDateTimeButtonWidget(
            currentDiary: diary,
            context: context,
            handleToolbarChangeDiary: handleChangeDiary,
            tooltip: l10n.changeDate,
          ),
        ],
      ),
    );
  }
}
