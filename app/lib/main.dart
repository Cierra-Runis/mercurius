import 'package:mercurius/index.dart';

void main() => App.run();

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  Widget builder(context, child) => Column(
        children: [
          if (Platform.isWindows || Platform.isMacOS) const WindowAppBar(),
          Expanded(child: ClipRRect(child: child)),
        ],
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSchemes = ref.watch(colorSchemesProvider);
    final settings = ref.watch(settingsProvider);

    const appBarTheme = AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    );

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorSchemes.light,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: App.fontSaira,
      fontFamilyFallback: const [App.fontMiSans],
      appBarTheme: appBarTheme,
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: colorSchemes.dark,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: App.fontSaira,
      fontFamilyFallback: const [App.fontMiSans],
      appBarTheme: appBarTheme,
    );

    return MaterialApp(
      scrollBehavior: const _ScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: settings.themeMode,
      builder: builder,
      home: const BasedSplashPage(
        rootPage: RootPage(),
        appIcon: AppIcon(),
        appName: AppName(fontSize: 42),
      ),
      locale: settings.locale,
      localizationsDelegates: const [
        L10N.delegate,
        ...FlutterQuillLocalizations.localizationsDelegates,
      ],
      supportedLocales: App.supportLanguages.values,
    );
  }
}

class _ScrollBehavior extends CupertinoScrollBehavior {
  const _ScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
