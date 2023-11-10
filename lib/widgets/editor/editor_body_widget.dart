import 'package:mercurius/index.dart';

class EditorBodyWidget extends StatelessWidget {
  const EditorBodyWidget({
    super.key,
    required this.scrollController,
    required this.readOnly,
  });

  final ScrollController scrollController;
  final bool readOnly;
  bool get autoFocus => !readOnly;
  bool get showCursor => !readOnly;
  bool get enableInteractiveSelection => !readOnly;
  bool get enableSelectionToolbar => !readOnly;

  static const embedBuilders = [
    DiaryImageEmbedBuilderWidget(),
    DiaryTagEmbedBuilderWidget(),
  ];

  static final unknownEmbedBuilder = DeprecatedEmbed();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return QuillEditor(
      focusNode: FocusNode(),
      scrollController: scrollController,
      configurations: QuillEditorConfigurations(
        scrollable: true,
        enableInteractiveSelection: enableInteractiveSelection,
        enableSelectionToolbar: enableSelectionToolbar,
        showCursor: showCursor,
        expands: false,
        padding: const EdgeInsets.all(2.0),
        autoFocus: autoFocus,
        placeholder: l10n.writingSomethingHere,
        readOnly: readOnly,
        onLaunchUrl: (url) {
          try {
            launchUrlString(
              url,
              mode: LaunchMode.externalApplication,
            );
          } catch (e) {
            App.printLog('launch $url failed: $e');
          }
        },
        scrollBottomInset: 10,
        embedBuilders: embedBuilders,
        unknownEmbedBuilder: unknownEmbedBuilder,
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
              color: context.colorScheme.inverseSurface,
            ),
            const VerticalSpacing(3, 3),
            const VerticalSpacing(0, 0),
            null,
          ),
        ),
      ),
    );
  }
}
