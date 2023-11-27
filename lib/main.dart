import 'package:mercurius/index.dart';

/// isar 数据库
final isarService = IsarService();

void main() => App.run();

class MercuriusApp extends ConsumerWidget {
  const MercuriusApp({super.key});

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
      scrollBehavior: const PlatformScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: settings.themeMode,
      home: BasedSplashPage(
        rootPage: Column(
          children: [
            if (Platform.isWindows) const WindowAppBar(),
            const Expanded(child: RootView()),
          ],
        ),
        appIcon: const AppIcon(),
        appName: const AppName(fontSize: 42),
      ),
      localizationsDelegates: const [
        L10N.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('zh', 'CN'),
        Locale('ja'),
      ],
    );
  }
}
