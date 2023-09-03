import 'package:mercurius/index.dart';

class EditorBodyWidget extends StatelessWidget {
  const EditorBodyWidget({
    super.key,
    required this.scrollController,
    required this.quillController,
    required this.readOnly,
  });

  final ScrollController scrollController;
  final QuillController quillController;
  final bool readOnly;
  bool get autoFocus => !readOnly;
  bool get showCursor => !readOnly;
  bool get enableInteractiveSelection => !readOnly;
  bool get enableSelectionToolbar => !readOnly;

  static const List<EmbedBuilder> embedBuilders = [
    DiaryImageEmbedBuilderWidget(),
    DiaryTagEmbedBuilderWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return QuillEditor(
      locale: Localizations.localeOf(context),
      focusNode: FocusNode(),
      scrollController: scrollController,
      scrollable: true,
      enableInteractiveSelection: enableInteractiveSelection,
      enableSelectionToolbar: enableSelectionToolbar,
      showCursor: showCursor,
      expands: false,
      padding: const EdgeInsets.all(2.0),
      autoFocus: autoFocus,
      placeholder: l10n.writingSomethingHere,
      controller: quillController,
      readOnly: readOnly,
      onLaunchUrl: (url) {
        try {
          launchUrlString(
            url,
            mode: LaunchMode.externalApplication,
          );
        } catch (e) {
          Mercurius.printLog('launch $url failed: $e');
        }
      },
      scrollBottomInset: 10,
      embedBuilders: embedBuilders,
      customStyles: DefaultStyles(
        placeHolder: DefaultTextBlockStyle(
          TextStyle(
            fontFamily: 'Saira',
            fontSize: 14,
            height: 1.5,
            color: Colors.grey.withOpacity(0.6),
          ),
          const VerticalSpacing(3, 3),
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
          const VerticalSpacing(3, 3),
          const VerticalSpacing(0, 0),
          null,
        ),
      ),
    );
  }
}
