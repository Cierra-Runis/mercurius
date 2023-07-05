import 'package:mercurius/index.dart';

/// 全局导航 key
final navigatorKey = GlobalKey<NavigatorState>();

/// isar 数据库
final isarService = IsarService();

void main() => Mercurius.run();

class MercuriusApp extends StatelessWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context) {
    Mercurius.printLog('正在构建 $this');

    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: Mercurius.lightColorScheme,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: 'Saira',
    );

    ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: Mercurius.darkColorScheme,
      datePickerTheme: const DatePickerThemeData(
        dayStyle: TextStyle(fontSize: 12),
      ),
      fontFamily: 'Saira',
    );

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) => MaterialApp(
        scrollBehavior: const PlatformScrollBehavior(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: snapshot.data?.themeMode,
        home: const MercuriusSplashPage(),
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
