import 'package:mercurius/index.dart';

/// 位于 `main.dart` 的 `changeNotifier` 们
final mercuriusProfileNotifier = MercuriusProfileNotifier();
final mercuriusSudokuNotifier = MercuriusSudokuNotifier();
final mercuriusPositionNotifier = MercuriusPositionNotifier();
final mercuriusPathNotifier = MercuriusPathNotifier();

/// 数据库服务
final isarService = IsarService();

/// 全局导航 key
final navigatorKey = GlobalKey<NavigatorState>();

/// 因 `mercuriusProfileNotifier` 需要读取本地数据, 故先进入 `mercuriusProfileNotifier` 进行初始化
Future<void> main() async {
  await mercuriusProfileNotifier.init();
  runApp(const ProviderScope(child: MercuriusApp()));
}

class MercuriusApp extends ConsumerWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MercuriusKit.printLog('正在构建 MercuriusApp');
    ref.watch(githubLatestReleaseProvider);

    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: MercuriusConstance.lightColorScheme,
      fontFamily: 'Saira',
    );

    ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: MercuriusConstance.darkColorScheme,
      fontFamily: 'Saira',
    );

    /// 利用 `provide` 包进行状态管理
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => mercuriusProfileNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusSudokuNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusPositionNotifier),
        ChangeNotifierProvider(create: (_) => mercuriusPathNotifier),
      ],
      child: Consumer<MercuriusProfileNotifier>(
        builder: (context, mercuriusProfileNotifier, child) => MaterialApp(
          scrollBehavior: const CupertinoScrollBehavior(),
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
        ),
      ),
    );
  }
}
