import 'package:mercurius/index.dart';

/// 位于 `main.dart` 的 `changeNotifier` 们
final mercuriusProfileNotifier = MercuriusProfileNotifier();
final mercuriusSudokuNotifier = MercuriusSudokuNotifier();
final mercuriusWebNotifier = MercuriusWebNotifier();
final mercuriusPositionNotifier = MercuriusPositionNotifier();
final mercuriusPathNotifier = MercuriusPathNotifier();
final mercuriusLogNotifier = MercuriusLogNotifier();
final diarySearchTextNotifier = DiarySearchTextNotifier();

/// 数据库服务
final isarService = IsarService();

/// 全局导航 key
final navigatorKey = GlobalKey<NavigatorState>();

/// 因 `mercuriusProfileNotifier` 需要读取本地数据, 故先进入 `mercuriusProfileNotifier` 进行初始化
void main() =>
    mercuriusProfileNotifier.init().then((e) => runApp(const MercuriusApp()));

class MercuriusApp extends StatelessWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: MercuriusConstance.lightColorScheme,
      platform: TargetPlatform.iOS,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      fontFamily: 'Saira',
    );

    ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: MercuriusConstance.darkColorScheme,
      platform: TargetPlatform.iOS,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      fontFamily: 'Saira',
    );

    /// 利用 `provide` 包进行状态管理
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => mercuriusProfileNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusSudokuNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusWebNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusPositionNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusPathNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusLogNotifier),
        ChangeNotifierProvider(create: (_) => diarySearchTextNotifier),
      ],
      child: Consumer<MercuriusProfileNotifier>(
        builder: (context, mercuriusProfileNotifier, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: theme,
            darkTheme: darkTheme,
            themeMode: mercuriusProfileNotifier.profile.themeMode,
            home: const MercuriusSplashPage(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('zh', 'CN'),
            ],
          );
        },
      ),
    );
  }
}
