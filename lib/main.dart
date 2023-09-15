import 'package:mercurius/index.dart';

/// isar 数据库
final isarService = IsarService();

void main() => Mercurius.run();

class MercuriusApp extends StatelessWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context) {
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

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) => MaterialApp(
        scrollBehavior: const PlatformScrollBehavior(),
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: snapshot.data?.themeMode,
        home: const SplashPage(),
        localizationsDelegates: const [
          MercuriusL10N.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('zh', 'CN'),
          Locale('ja'),
        ],
      ),
    );
  }
}
