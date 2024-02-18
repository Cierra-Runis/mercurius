import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'color_schemes.g.dart';
part 'color_schemes.freezed.dart';

@freezed
class ColorSchemesState with _$ColorSchemesState {
  const ColorSchemesState._();

  const factory ColorSchemesState({
    required ColorScheme light,
    required ColorScheme dark,
  }) = _ColorSchemesState;

  ({ThemeData theme, ThemeData darkTheme}) toThemes() {
    const appBarTheme = AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    );

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: light,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: App.fontSaira,
      fontFamilyFallback: const [App.fontMiSans],
      appBarTheme: appBarTheme,
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: dark,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: App.fontSaira,
      fontFamilyFallback: const [App.fontMiSans],
      appBarTheme: appBarTheme,
    );

    return (theme: theme, darkTheme: darkTheme);
  }
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
