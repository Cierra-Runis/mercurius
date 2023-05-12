import 'package:mercurius/index.dart';

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

    return MaterialApp(
      scrollBehavior: const CupertinoScrollBehavior(),
      navigatorKey: navigatorKey,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: mercuriusProfile.when(
        loading: () {
          MercuriusKit.printLog('正在读取 MercuriusProfile 中的 themeMode');
          return ThemeMode.system;
        },
        error: (error, stackTrace) => ThemeMode.system,
        data: (data) {
          MercuriusKit.printLog('读取完毕 MercuriusProfile 中的 themeMode');
          return data.themeMode;
        },
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
    );
  }
}
