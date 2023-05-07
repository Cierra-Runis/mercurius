import 'package:mercurius/index.dart';

/// 位于 `main.dart` 的 `changeNotifier` 们
final mercuriusSudokuNotifier = MercuriusSudokuNotifier();

/// 全局导航 key
final navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(const ProviderScope(child: MercuriusApp()));

class MercuriusApp extends ConsumerWidget {
  const MercuriusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MercuriusKit.printLog('正在构建 $this');

    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

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
        ChangeNotifierProvider(create: (_) => mercuriusSudokuNotifier),
      ],
      child: MaterialApp(
        scrollBehavior: const CupertinoScrollBehavior(),
        navigatorKey: navigatorKey,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: mercuriusProfile.when(
          loading: () => ThemeMode.system,
          error: (error, stackTrace) => ThemeMode.system,
          data: (data) => data.themeMode,
        ),
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
    );
  }
}
