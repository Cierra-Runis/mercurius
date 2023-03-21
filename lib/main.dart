import 'package:mercurius/index.dart';

import 'package:flutter/cupertino.dart';

/// 位于 `main.dart` 的 `changeNotifier` 们
MercuriusProfileNotifier mercuriusProfileNotifier = MercuriusProfileNotifier();
MercuriusSudokuNotifier mercuriusSudokuNotifier = MercuriusSudokuNotifier();
MercuriusWebNotifier mercuriusWebNotifier = MercuriusWebNotifier();
MercuriusPositionNotifier mercuriusPositionNotifier =
    MercuriusPositionNotifier();
MercuriusLogNotifier mercuriusLogNotifier = MercuriusLogNotifier();
MercuriusPathNotifier mercuriusPathNotifier = MercuriusPathNotifier();
DiaryEditorNotifier diaryEditorNotifier = DiaryEditorNotifier();
DiarySearchTextNotifier diarySearchTextNotifier = DiarySearchTextNotifier();

/// 数据库服务
final isarService = IsarService();

/// 因 `mercuriusProfileNotifier` 需要读取本地数据, 故先进入 `mercuriusProfileNotifier` 进行初始化
void main() =>
    mercuriusProfileNotifier.init().then((e) => runApp(const MercuriusApp()));

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MercuriusApp extends StatelessWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context) {
    DevTools.printLog('MercuriusApp 构建中');

    /// 利用 `provide` 包进行状态管理
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => mercuriusProfileNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusSudokuNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusWebNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusPositionNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusPathNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusLogNotifier),
        ChangeNotifierProvider(create: (_) => diaryEditorNotifier),
        ChangeNotifierProvider(create: (_) => diarySearchTextNotifier),
      ],
      child: Consumer<MercuriusProfileNotifier>(
        builder: (context, mercuriusProfileNotifier, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightColorScheme,
              fontFamily: 'Saira',
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder()
              }),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkColorScheme,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder()
              }),
              fontFamily: 'Saira',
            ),
            themeMode: mercuriusProfileNotifier.profile.themeMode,
            home: const MercuriusSplashPage(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
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
