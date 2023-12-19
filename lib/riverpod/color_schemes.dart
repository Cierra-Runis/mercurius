import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'color_schemes.g.dart';

@Riverpod(keepAlive: true)
ColorSchemes colorSchemes(ColorSchemesRef ref) =>
    throw Exception('colorSchemesProvider not initialized');

class ColorSchemes {
  final ColorScheme light;
  final ColorScheme dark;

  const ColorSchemes._(this.light, this.dark);

  static Future<ColorSchemes> init() async {
    final palette = await DynamicColorPlugin.getCorePalette();

    final seedColor =
        await DynamicColorPlugin.getAccentColor() ?? Colors.deepPurple;

    final light = palette?.toColorScheme(brightness: Brightness.light) ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        );

    final dark = palette?.toColorScheme(brightness: Brightness.dark) ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );

    return ColorSchemes._(light, dark);
  }
}
