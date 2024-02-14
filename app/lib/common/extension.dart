import 'package:mercurius/index.dart';

extension CacheForExtension on AutoDisposeRef<Object?> {
  /// Refresh provider each [duration].
  void refreshFor(Duration duration) {
    /// Immediately prevent the state from getting destroyed.
    keepAlive();

    /// After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, invalidateSelf);

    /// Optional: when the provider is recomputed (such as with ref.watch),
    /// we cancel the pending timer.
    onDispose(timer.cancel);
  }
}

extension BuildContextExt on BuildContext {
  NavigatorState get _navigator =>
      splitViewKey.currentState ?? Navigator.of(this);

  Future<T?> push<T extends Object?>(Widget page) =>
      _navigator.push(CupertinoPageRoute<T>(builder: (_) => page));

  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);

  Future<T?> pushDialog<T>(
    Widget dialog, {
    bool barrierDismissible = true,
    String? barrierLabel,
    bool useSafeArea = false,
    RouteSettings? settings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) =>
      _navigator.push(
        DialogRoute(
          context: _navigator.context,
          barrierDismissible: barrierDismissible,
          useSafeArea: useSafeArea,
          settings: settings,
          anchorPoint: anchorPoint,
          traversalEdgeBehavior: traversalEdgeBehavior,
          builder: (context) => Material(
            type: MaterialType.transparency,
            child: dialog,
          ),
        ),
      );

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Brightness get brightness => colorScheme.brightness;

  L10N get l10n => L10N.maybeOf(this) ?? L10N.current;
}

extension StringExt on String {
  Pattern tryParse() {
    try {
      return RegExp(this);
    } on FormatException {
      return this;
    }
  }
}

extension BrightnessExt on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}

extension DefaultStylesExt on DefaultStyles {
  static DefaultStyles material({
    required BuildContext context,
    required String fontFamily,
    required String codeFontFamily,
    List<String> fontFamilyFallback = const [],
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    final baseStyle = TextStyle(
      color: colorScheme.onBackground,
      fontFamily: fontFamily,
      fontFamilyFallback: [codeFontFamily, ...fontFamilyFallback],
      height: 4 / 3,
    );

    const verticalSpacing = VerticalSpacing(4, 4);
    const lineSpacing = VerticalSpacing(2, 2);

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
      radius: const Radius.circular(120),
    );

    final link = small.copyWith(
      color: colorScheme.primary,
      fontFamily: codeFontFamily,
      fontFamilyFallback: [fontFamily, ...fontFamilyFallback],
      decoration: TextDecoration.underline,
    );

    final placeholder = DefaultTextBlockStyle(
      baseStyle.copyWith(
        color: colorScheme.outline,
      ),
      verticalSpacing,
      lineSpacing,
      const BoxDecoration(),
    );

    final lists = DefaultListBlockStyle(
      small.copyWith(
        fontFamily: codeFontFamily,
        fontFamilyFallback: [fontFamily, ...fontFamilyFallback],
      ),
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
            color: colorScheme.primary,
            width: 4,
          ),
        ),
      ),
    );

    final code = DefaultTextBlockStyle(
      small.copyWith(
        color: colorScheme.secondary,
        fontFamily: codeFontFamily,
        fontFamilyFallback: [fontFamily, ...fontFamilyFallback],
      ),
      verticalSpacing,
      lineSpacing,
      BoxDecoration(
        color: colorScheme.secondaryContainer,
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
}
