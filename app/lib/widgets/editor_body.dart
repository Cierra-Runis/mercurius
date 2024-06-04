import 'package:mercurius/index.dart';

class EditorBody extends ConsumerWidget {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);

    return QuillEditor(
      focusNode: FocusNode(),
      scrollController: scrollController,
      configurations: QuillEditorConfigurations(
        /// TIPS: This is important,
        /// TIPS: It means [scrollController] is from another scroll view
        /// TIPS: where the editor scrolling behavior shows
        scrollable: false,
        controller: controller..readOnly = readOnly,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        autoFocus: autoFocus,
        placeholder: l10n.writingSomethingHere,
        keyboardAppearance: context.brightness,
        enableInteractiveSelection: enableInteractiveSelection,
        enableSelectionToolbar: enableSelectionToolbar,
        showCursor: showCursor,
        onLaunchUrl: App.launchUrl,
        scrollBottomInset: 10,
        embedBuilders: embedBuilders,
        unknownEmbedBuilder: unknownEmbedBuilder,
        readOnlyMouseCursor: SystemMouseCursors.alias,
        customStyles: DefaultStylesExt.material(
          context: context,
          fontFamily: settings.fontFamily,
          codeFontFamily: App.fontCascadiaCodePL,
        ),
      ),
    );
  }
}
