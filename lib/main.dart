import 'package:mercurius/index.dart';

/// isar 数据库
final isarService = IsarService();

void main() => App.run();

class MercuriusApp extends ConsumerWidget {
  const MercuriusApp({super.key});

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
      scrollBehavior: const PlatformScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: settings.themeMode,
      builder: builder,
      home: const BasedSplashPage(
        rootPage: RootView(),
        appIcon: AppIcon(),
        appName: AppName(fontSize: 42),
      ),
      locale: settings.locale,
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
