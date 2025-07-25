import 'package:mercurius/index.dart';

class EditorBody extends ConsumerWidget {
  static const embedBuilders = [
    ImageBlockEmbedBuilder(),
    TagBlockEmbedBuilder(),
  ];

  static const unknownEmbedBuilder = DeprecatedEmbedBuilder();
  final QuillController controller;
  final ScrollController scrollController;
  final bool readOnly;
  const EditorBody({
    super.key,
    required this.controller,
    required this.scrollController,
    required this.readOnly,
  });
  bool get autoFocus => !readOnly;
  bool get enableInteractiveSelection => !readOnly;

  bool get enableSelectionToolbar => !readOnly;

  bool get showCursor => !readOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);

    return QuillEditor(
      controller: controller..readOnly = readOnly,
      focusNode: FocusNode(),
      scrollController: scrollController,
      config: QuillEditorConfig(
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
