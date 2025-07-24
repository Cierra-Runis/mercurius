import 'dart:math' as math;

import 'package:mercurius/index.dart';

part 'bytes.dart';
part 'default_styles.dart';
part 'iterable.dart';

extension BrightnessExt on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}

extension BuildContextExt on BuildContext {
  Brightness get brightness => colorScheme.brightness;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  L10N get l10n => L10N.maybeOf(this) ?? L10N.current;

  String get languageTag => Localizations.localeOf(this).toLanguageTag();

  MaterialLocalizations get ml10n => MaterialLocalizations.of(this);
  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);

  Future<T?> push<T extends Object?>(Widget page) =>
      _navigator().push(CupertinoPageRoute<T>(builder: (_) => page));

  Future<T?> pushDialog<T>(
    Widget dialog, {
    bool useRootNavigator = true,
  }) {
    final navigator = _navigator(useRootNavigator: useRootNavigator);
    return navigator.push(
      DialogRoute(
        context: navigator.context,
        builder: (context) => Material(
          type: MaterialType.transparency,
          child: dialog,
        ),
      ),
    );
  }

  NavigatorState _navigator({
    bool useRootNavigator = false,
  }) =>
      useRootNavigator
          ? Navigator.of(this, rootNavigator: true)
          : App.splitViewKey.currentState ?? Navigator.of(this);
}

extension CacheForExt on Ref<Object?> {
  /// Refresh provider each [duration].
  void refreshFor(Duration duration) {
    /// Immediately prevent the state from getting destroyed.
    keepAlive();

    /// After duration has elapsed, we invalidateSelf.
    final timer = Timer(duration, invalidateSelf);

    /// Optional: when the provider is recomputed (such as with ref.watch),
    /// we cancel the pending timer.
    onDispose(timer.cancel);
  }
}

extension DocumentExt on Document {
  String get plainText => toPlainText(
        EditorBody.embedBuilders,
        EditorBody.unknownEmbedBuilder,
      );

  bool get plainTextIsEmpty => plainText.length <= 1;
}
