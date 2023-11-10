import 'package:mercurius/index.dart';

extension BuildContextExtension on BuildContext {
  Future<T?> push<T extends Object?>(Widget page) => splitViewKey.currentState!
      .push(CupertinoPageRoute<T>(builder: (_) => page));

  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Brightness get brightness => colorScheme.brightness;

  L10N get l10n => L10N.of(this);
}

extension BrightnessExtension on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}
