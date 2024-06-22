import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_schemes.freezed.dart';
part 'color_schemes.g.dart';

@freezed
class ColorSchemesState with _$ColorSchemesState {
  const ColorSchemesState._();

  const factory ColorSchemesState({
    required ColorScheme light,
    required ColorScheme dark,
  }) = _ColorSchemesState;

  ({ThemeData theme, ThemeData darkTheme}) toThemes(String? fontFamily) {
    const appBarTheme = AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    );

    const cardTheme = CardTheme(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
    );

    const expansionTileTheme = ExpansionTileThemeData(
      shape: Border(),
      collapsedShape: Border(),
    );

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: light,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: App.fontSize12),
      ),
      fontFamily: fontFamily,
      appBarTheme: appBarTheme.copyWith(color: light.surface),
      cardTheme: cardTheme,
      expansionTileTheme: expansionTileTheme,
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: dark,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: App.fontSize12),
      ),
      fontFamily: fontFamily,
      appBarTheme: appBarTheme.copyWith(color: dark.surface),
      cardTheme: cardTheme,
      expansionTileTheme: expansionTileTheme,
    );

    return (theme: theme, darkTheme: darkTheme);
  }
}

@riverpod
class ColorSchemes extends _$ColorSchemes {
  @override
  ColorSchemesState build() {
    final dynamicColor = ref.watch(dynamicColorProvider);
    final accentColor = ref.watch(
      settingsProvider.select((value) => value.accentColor),
    );

    if (accentColor != null) {
      return ColorSchemesState(
        light: ColorScheme.fromSeed(
          seedColor: accentColor,
        ),
        dark: ColorScheme.fromSeed(
          seedColor: accentColor,
          brightness: Brightness.dark,
        ),
      );
    }

    final corePalette = dynamicColor.corePalette;

    if (corePalette != null) {
      return ColorSchemesState(
        light: corePalette.toColorScheme(),
        dark: corePalette.toColorScheme(
          brightness: Brightness.dark,
        ),
      );
    }

    final seedColor = dynamicColor.seedColor;

    return ColorSchemesState(
      light: ColorScheme.fromSeed(
        seedColor: seedColor,
      ),
      dark: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
