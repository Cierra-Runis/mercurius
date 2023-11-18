import 'package:mercurius/index.dart';

/// isar 数据库
final isarService = IsarService();

void main() => App.run();

class MercuriusApp extends ConsumerWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: App.lightColorScheme,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: 'Saira',
      appBarTheme: const AppBarTheme(centerTitle: true),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: App.darkColorScheme,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: 'Saira',
      appBarTheme: const AppBarTheme(centerTitle: true),
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
