import 'dart:math' as math;

import 'package:mercurius/index.dart';

part 'bytes.dart';
part 'default_styles.dart';
part 'iterable.dart';

extension CacheForExtension on AutoDisposeRef<Object?> {
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

extension BuildContextExt on BuildContext {
  NavigatorState get _navigator =>
      App.splitViewKey.currentState ?? Navigator.of(this);

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
  String get languageTag => Localizations.localeOf(this).toLanguageTag();
}

extension BrightnessExt on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}
