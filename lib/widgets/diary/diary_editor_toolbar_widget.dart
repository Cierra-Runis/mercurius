import 'package:mercurius/index.dart';

class DiaryEditorToolbarWidget extends StatelessWidget {
  const DiaryEditorToolbarWidget({
    Key? key,
    required this.currentDiary,
    required this.scrollController,
    required this.controller,
    required this.handleToolbarChangeDiary,
  }) : super(key: key);

  final Diary currentDiary;
  final ScrollController scrollController;
  final QuillController controller;
  final ValueChanged<Diary?> handleToolbarChangeDiary;

  @override
  Widget build(BuildContext context) {
    final iconSelectedFillColor =
        Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.outlineVariant
            : Theme.of(context).colorScheme.primaryContainer;

    final quillIconTheme = QuillIconTheme(
      borderRadius: 12,
      iconSelectedFillColor: iconSelectedFillColor,
    );

    List<EmbedButtonBuilder> embedButtons = [
      (controller, _, __, ___) {
        return DiaryEditorToolbarImageButtonWidget(
          controller: controller,
        );
      }
    ];

    return QuillToolbar.basic(
      controller: controller,
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
      toolbarSectionSpacing: 4,
      iconTheme: quillIconTheme,
      embedButtons: embedButtons,
      customButtons: [
        DiaryEditorToolbarTimestampButtonWidget(controller: controller),
        QuillCustomButton(
          icon: Icons.mood,
          onTap: () async {
            Diary? newDiary = await showDialog<Diary>(
              context: context,
              builder: (BuildContext context) {
                return DiaryMoodSelectorWidget(
                  diary: currentDiary,
                );
              },
            );
            handleToolbarChangeDiary(newDiary);
          },
        ),
        QuillCustomButton(
          icon: Icons.cloud,
          onTap: () async {
            Diary? newDiary = await showDialog<Diary>(
              context: context,
              builder: (BuildContext context) {
                return DiaryWeatherSelectorDialogWidget(
                  diary: currentDiary,
                );
              },
            );
            handleToolbarChangeDiary(newDiary);
          },
        ),
        QuillCustomButton(
          icon: Icons.date_range_rounded,
          onTap: () async {
            DateTime? dateTime = await showDatePicker(
              context: context,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              initialDate: DateTime.now(),
              firstDate: DateTime(1949, 10, 1),
              lastDate: DateTime.now().add(
                const Duration(days: 20000),
              ),
            );
            if (dateTime != null) {
              handleToolbarChangeDiary(
                Diary.copyFrom(
                  currentDiary,
                  createDateTime: dateTime,
                ),
              );
            }
          },
        ),
      ],
      locale: const Locale('zh', 'CN'),
    );
  }
}
