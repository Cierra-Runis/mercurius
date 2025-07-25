import 'package:mercurius/index.dart';

class HighlightText extends StatelessWidget {
  final String text;

  final Pattern pattern;
  final HighlightTextController? controller;
  final TextStyle? textStyle;
  final TextStyle? highlightStyle;
  final List<TextSpan> Function(List<TextSpan> spans)? spansTransform;
  final TextOverflow? overflow;

  final int? maxLines;
  const HighlightText({
    super.key,
    required this.text,
    required this.pattern,
    this.controller,
    this.textStyle,
    this.highlightStyle,
    this.spansTransform,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultStyle = DefaultTextStyle.of(context).style;
    final textStyle = this.textStyle ?? defaultStyle;
    final highlightStyle = this.highlightStyle ??
        textStyle.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
          backgroundColor: colorScheme.primaryContainer,
        );

    final spans = praseSpans(
      text,
      pattern,
      textStyle,
      highlightStyle,
    );

    final finalSpans = spansTransform?.call(spans) ?? spans;

    return Text.rich(
      TextSpan(children: finalSpans),
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  List<TextSpan> praseSpans(
    String text,
    Pattern regex,
    TextStyle textStyle,
    TextStyle highlightStyle,
  ) {
    final normal = text.split(pattern);
    final matches =
        pattern.allMatches(text).map((e) => e.group(0) ?? '').toList();

    /// FIXME: Bad implement
    controller?.count = matches.length;

    final result = <TextSpan>[];
    for (var i = 0; i < normal.length || i < matches.length; i++) {
      if (i < normal.length) {
        result.add(TextSpan(text: normal[i], style: textStyle));
      }
      if (i < matches.length) {
        result.add(TextSpan(text: matches[i], style: highlightStyle));
      }
    }

    return result;
  }
}

class HighlightTextController extends ChangeNotifier {
  int count = 0;

  HighlightTextController();
}
