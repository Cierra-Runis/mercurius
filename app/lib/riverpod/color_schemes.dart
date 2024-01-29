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

    if (settings.accentColor != null) {
      return ColorSchemesState(
        light: ColorScheme.fromSeed(
          seedColor: settings.accentColor!,
        ),
        dark: ColorScheme.fromSeed(
          seedColor: settings.accentColor!,
          brightness: Brightness.dark,
        ),
      );
    }

    if (dynamicColor.corePalette != null) {
      return ColorSchemesState(
        light: dynamicColor.corePalette!.toColorScheme(),
        dark: dynamicColor.corePalette!.toColorScheme(
          brightness: Brightness.dark,
        ),
      );
    }

    return ColorSchemesState(
      light: ColorScheme.fromSeed(
        seedColor: dynamicColor.seedColor,
      ),
      dark: ColorScheme.fromSeed(
        seedColor: dynamicColor.seedColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
