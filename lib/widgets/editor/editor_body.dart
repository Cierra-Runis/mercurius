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
    DiaryImageEmbedBuilder(),
    DiaryTagEmbedBuilder(),
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
    final l10n = L10N.current;

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
        customStyles: customStyles(context),
      ),
    );
  }
}

DefaultStyles customStyles(BuildContext context) {
  final baseStyle = TextStyle(
    color: context.colorScheme.onBackground,
    fontFamily: App.fontSaira,
    fontFamilyFallback: const [App.fontCascadiaCodePL, App.fontMiSans],
    height: 4 / 3,
  );

  const verticalSpacing = VerticalSpacing(4, 4);
  const lineSpacing = VerticalSpacing(0, 0);

  final h1 = DefaultTextBlockStyle(
    baseStyle.copyWith(fontSize: 20),
    verticalSpacing,
    lineSpacing,
    const BoxDecoration(),
  );

  final h2 = DefaultTextBlockStyle(
    baseStyle.copyWith(fontSize: 18),
    verticalSpacing,
    lineSpacing,
    const BoxDecoration(),
  );

  final h3 = DefaultTextBlockStyle(
    baseStyle.copyWith(fontSize: 16),
    verticalSpacing,
    lineSpacing,
    const BoxDecoration(),
  );

  final paragraph = DefaultTextBlockStyle(
    baseStyle,
    verticalSpacing,
    lineSpacing,
    const BoxDecoration(),
  );

  final bold = baseStyle.copyWith(
    fontWeight: FontWeight.bold,
  );
  final subscript = baseStyle.copyWith(
    fontFeatures: [const FontFeature.subscripts()],
  );
  final superscript = baseStyle.copyWith(
    fontFeatures: [const FontFeature.superscripts()],
  );
  final italic = baseStyle.copyWith(
    fontStyle: FontStyle.italic,
  );
  final small = baseStyle.copyWith(
    fontSize: 12,
  );
  final underline = baseStyle.copyWith(
    decoration: TextDecoration.underline,
  );
  final strikeThrough = baseStyle.copyWith(
    decoration: TextDecoration.lineThrough,
  );

  /// FIXME: backgroundColor no effect <https://github.com/singerdmx/flutter-quill/issues/1409>
  final inlineCode = InlineCodeStyle(
    style: baseStyle,
    backgroundColor: null,
    radius: const Radius.circular(120),
  );

  final link = small.copyWith(
    color: context.colorScheme.primary,
    fontFamily: App.fontCascadiaCodePL,
    decoration: TextDecoration.underline,
  );

  final placeholder = DefaultTextBlockStyle(
    baseStyle.copyWith(
      color: context.colorScheme.outline,
    ),
    verticalSpacing,
    lineSpacing,
    const BoxDecoration(),
  );

  final lists = DefaultListBlockStyle(
    small.copyWith(fontFamily: App.fontCascadiaCodePL),
    verticalSpacing,
    lineSpacing,
    const BoxDecoration(),
    null,
  );

  final quote = DefaultTextBlockStyle(
    placeholder.style,
    verticalSpacing,
    lineSpacing,
    BoxDecoration(
      border: Border(
        left: BorderSide(
          color: context.colorScheme.primary,
          width: 4,
        ),
      ),
    ),
  );

  final code = DefaultTextBlockStyle(
    small.copyWith(
      color: context.colorScheme.secondary,
      fontFamily: App.fontCascadiaCodePL,
    ),
    verticalSpacing,
    lineSpacing,
    BoxDecoration(
      color: context.colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(8),
    ),
  );

  final indent = DefaultTextBlockStyle(
    baseStyle,
    verticalSpacing,
    lineSpacing,
    null,
  );

  final align = DefaultTextBlockStyle(
    baseStyle,
    verticalSpacing,
    lineSpacing,
    null,
  );

  final leading = DefaultTextBlockStyle(
    baseStyle,
    verticalSpacing,
    lineSpacing,
    null,
  );

  final sizeSmall = baseStyle.copyWith(fontSize: 10);
  final sizeLarge = baseStyle.copyWith(fontSize: 16);
  final sizeHuge = baseStyle.copyWith(fontSize: 18);

  return DefaultStyles(
    h1: h1,
    h2: h2,
    h3: h3,
    paragraph: paragraph,
    bold: bold,
    subscript: subscript,
    superscript: superscript,
    italic: italic,
    small: small,
    underline: underline,
    strikeThrough: strikeThrough,
    inlineCode: inlineCode,
    link: link,
    placeHolder: placeholder,
    lists: lists,
    quote: quote,
    code: code,
    indent: indent,
    align: align,
    leading: leading,
    sizeSmall: sizeSmall,
    sizeLarge: sizeLarge,
    sizeHuge: sizeHuge,
  );
}
