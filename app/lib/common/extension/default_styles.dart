part of 'extension.dart';

extension DefaultStylesExt on DefaultStyles {
  static DefaultStyles material({
    required BuildContext context,
    String? fontFamily,
    required String codeFontFamily,
  }) {
    final colorScheme = context.colorScheme;

    final baseStyle = TextStyle(
      color: colorScheme.onSurface,
      fontFamily: fontFamily,
      height: 4 / 3,
    );

    const horizontalSpacing = HorizontalSpacing(2, 2);
    const verticalSpacing = VerticalSpacing(4, 4);
    const lineSpacing = VerticalSpacing(2, 2);

    final h1 = DefaultTextBlockStyle(
      baseStyle.copyWith(fontSize: App.fontSize20),
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      const BoxDecoration(),
    );

    final h2 = DefaultTextBlockStyle(
      baseStyle.copyWith(fontSize: App.fontSize18),
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      const BoxDecoration(),
    );

    final h3 = DefaultTextBlockStyle(
      baseStyle.copyWith(fontSize: App.fontSize16),
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      const BoxDecoration(),
    );

    final paragraph = DefaultTextBlockStyle(
      baseStyle,
      horizontalSpacing,
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
      fontSize: App.fontSize12,
    );
    final underline = baseStyle.copyWith(
      decoration: TextDecoration.underline,
    );
    final strikeThrough = baseStyle.copyWith(
      decoration: TextDecoration.lineThrough,
    );

    final inlineCode = InlineCodeStyle(
      style: baseStyle,
      radius: const Radius.circular(120),
    );

    final link = baseStyle.copyWith(
      color: colorScheme.primary,
      fontFamily: codeFontFamily,
      fontFamilyFallback: [
        if (fontFamily != null) fontFamily,
      ],
      decoration: TextDecoration.underline,
    );

    final placeholder = DefaultTextBlockStyle(
      baseStyle.copyWith(
        color: colorScheme.outline,
      ),
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      const BoxDecoration(),
    );

    final lists = DefaultListBlockStyle(
      baseStyle,
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      const BoxDecoration(),
      null,
    );

    final quote = DefaultTextBlockStyle(
      placeholder.style,
      horizontalSpacing,
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
      baseStyle.copyWith(
        color: colorScheme.secondary,
        fontFamily: codeFontFamily,
        fontFamilyFallback: [
          if (fontFamily != null) fontFamily,
        ],
      ),
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final indent = DefaultTextBlockStyle(
      baseStyle,
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      null,
    );

    final align = DefaultTextBlockStyle(
      baseStyle,
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      null,
    );

    final leading = DefaultTextBlockStyle(
      baseStyle,
      horizontalSpacing,
      verticalSpacing,
      lineSpacing,
      null,
    );

    final sizeSmall = baseStyle.copyWith(fontSize: App.fontSize12);
    final sizeLarge = baseStyle.copyWith(fontSize: App.fontSize16);
    final sizeHuge = baseStyle.copyWith(fontSize: App.fontSize18);

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
