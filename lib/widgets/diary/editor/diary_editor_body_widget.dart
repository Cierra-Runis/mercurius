import 'package:mercurius/index.dart';

class DiaryEditorBodyWidget extends StatelessWidget {
  const DiaryEditorBodyWidget({
    super.key,
    required this.scrollController,
    required this.controller,
    required this.readOnly,
  });

  final ScrollController scrollController;
  final QuillController controller;
  final bool readOnly;
  bool get autoFocus => !readOnly;
  bool get showCursor => !readOnly;
  bool get enableInteractiveSelection => !readOnly;
  bool get enableSelectionToolbar => !readOnly;

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      locale: const Locale('zh', 'CN'),
      focusNode: FocusNode(),
      scrollController: scrollController,
      scrollable: true,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSelectionToolbar: enableSelectionToolbar,
      showCursor: showCursor,
      expands: false,
      padding: const EdgeInsets.all(2.0),
      autoFocus: autoFocus,
      placeholder: '记些什么吧',
      controller: controller,
      readOnly: readOnly,
      onLaunchUrl: (url) {
        launchUrlString(
          url,
          mode: LaunchMode.externalApplication,
        );
      },
      scrollBottomInset: 10,
      embedBuilders: [DiaryImageEmbedBuilderWidget()],
      customStyles: DefaultStyles(
        placeHolder: DefaultTextBlockStyle(
          TextStyle(
            fontFamily: 'Saira',
            fontSize: 14,
            height: 1.5,
            color: Colors.grey.withOpacity(0.6),
          ),
          const VerticalSpacing(0, 0),
          const VerticalSpacing(0, 0),
          null,
        ),
        paragraph: DefaultTextBlockStyle(
          TextStyle(
            fontFamily: 'Saira',
            fontSize: 14,
            height: 1.5,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
          const VerticalSpacing(0, 0),
          const VerticalSpacing(0, 0),
          null,
        ),
      ),
    );
  }
}
