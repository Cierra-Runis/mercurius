import '../../../app/lib/index.dart';

class EditorBody extends StatelessWidget {
  const EditorBody({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.readOnly,
  });

  final QuillController controller;
  final ScrollController scrollController;
  final bool readOnly;
  bool get autoFocus => !readOnly;
  bool get showCursor => !readOnly;
  bool get enableInteractiveSelection => !readOnly;
  bool get enableSelectionToolbar => !readOnly;

  static const embedBuilders = [
    ImageBlockEmbedBuilder(),
    TagBlockEmbedBuilder(),
  ];

  static const unknownEmbedBuilder = DeprecatedEmbedBuilder();

  void onLaunchUrl(url) {
    try {
      launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      App.printLog('launch $url failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return QuillEditor(
      focusNode: FocusNode(),
      scrollController: scrollController,
      configurations: QuillEditorConfigurations(
        controller: controller,
        padding: const EdgeInsets.all(14.0),
        autoFocus: autoFocus,
        placeholder: l10n.writingSomethingHere,
        keyboardAppearance: context.brightness,
        enableInteractiveSelection: enableInteractiveSelection,
        enableSelectionToolbar: enableSelectionToolbar,
        showCursor: showCursor,
        readOnly: readOnly,
        onLaunchUrl: onLaunchUrl,
        scrollBottomInset: 10,
        embedBuilders: embedBuilders,
        unknownEmbedBuilder: unknownEmbedBuilder,
        customStyles: DefaultStylesExt.material(
          context: context,
          fontFamily: App.fontSaira,
          codeFontFamily: App.fontCascadiaCodePL,
          fontFamilyFallback: [App.fontMiSans],
        ),
      ),
    );
  }
}
