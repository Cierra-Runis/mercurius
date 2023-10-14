import 'package:mercurius/index.dart';

extension BuildContextExtension on BuildContext {
  Future<T?> push<T extends Object?>(Widget page) =>
      Navigator.push(this, CupertinoPageRoute<T>(builder: (_) => page));

  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);

  Future<T?> pushAndRemoveRoot<T extends Object?>(Widget page) =>
      Navigator.pushAndRemoveUntil(
        this,
        CupertinoPageRoute<T>(builder: (_) => page),
        (_) => false,
      );

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Brightness get brightness => colorScheme.brightness;

  L10N get l10n => L10N.of(this);
}

extension BrightnessExtension on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}

extension DynamicExtension on dynamic {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}
