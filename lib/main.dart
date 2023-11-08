import 'package:mercurius/index.dart';

/// isar 数据库
final isarService = IsarService();

void main() => Mercurius.run();

class MercuriusApp extends ConsumerWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: Mercurius.lightColorScheme,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: 'Saira',
      appBarTheme: const AppBarTheme(centerTitle: true),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: Mercurius.darkColorScheme,
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
      home: const SplashPage(),
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
