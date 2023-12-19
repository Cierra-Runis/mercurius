import 'package:mercurius/index.dart';

class EditorBody extends StatelessWidget {
  const EditorBody({
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
        padding: const EdgeInsets.all(2.0),
        autoFocus: autoFocus,
        expands: false,
        placeholder: l10n.writingSomethingHere,
        keyboardAppearance: context.brightness,
        scrollable: true,
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
