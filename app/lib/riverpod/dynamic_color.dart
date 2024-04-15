import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_color.g.dart';

@Riverpod(keepAlive: true)
DynamicColor dynamicColor(DynamicColorRef ref) =>
    throw Exception('dynamicColorProvider not initialized');

class DynamicColor {
  final CorePalette? corePalette;
  final Color seedColor;

  const DynamicColor._({
    this.corePalette,
    required this.seedColor,
  });

  static Future<DynamicColor> init() async {
    final corePalette = await DynamicColorPlugin.getCorePalette();
    final accentColor = await DynamicColorPlugin.getAccentColor();
    final seedColor = accentColor ?? Colors.deepPurple;
    return DynamicColor._(corePalette: corePalette, seedColor: seedColor);
  }
}
