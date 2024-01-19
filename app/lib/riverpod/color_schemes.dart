import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'color_schemes.g.dart';
part 'color_schemes.freezed.dart';

@freezed
class ColorSchemesState with _$ColorSchemesState {
  const factory ColorSchemesState({
    required ColorScheme light,
    required ColorScheme dark,
  }) = _ColorSchemesState;
}

@riverpod
class ColorSchemes extends _$ColorSchemes {
  @override
  ColorSchemesState build() {
    final dynamicColor = ref.watch(dynamicColorProvider);
    final settings = ref.watch(settingsProvider);
    final seedColor = settings.accentColor ?? dynamicColor.seedColor;

    final light = dynamicColor.corePalette?.toColorScheme() ??
        ColorScheme.fromSeed(seedColor: seedColor);

    final dark = dynamicColor.corePalette
            ?.toColorScheme(brightness: Brightness.dark) ??
        ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);

    return ColorSchemesState(light: light, dark: dark);
  }
}
