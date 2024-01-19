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
    required this.seedColor,
    this.corePalette,
  });

  static Future<DynamicColor> init() async {
    final seedColor =
        await DynamicColorPlugin.getAccentColor() ?? Colors.deepPurple;
    final corePalette = await DynamicColorPlugin.getCorePalette();
    return DynamicColor._(
      seedColor: seedColor,
      corePalette: corePalette,
    );
  }
}
