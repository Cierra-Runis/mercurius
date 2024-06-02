import 'package:mercurius/index.dart';

void main() => App.run();

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  Widget builder(BuildContext context, Widget? child) {
    return Column(
      children: [
        if (Platform.isWindows || Platform.isMacOS) const WindowAppBar(),
        Expanded(child: ClipRRect(child: child)),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSchemes = ref.watch(colorSchemesProvider);
    final settings = ref.watch(settingsProvider);

    final themes = colorSchemes.toThemes(settings.fontFamily);

    return MaterialApp(
      scrollBehavior: const _ScrollBehavior(),
      theme: themes.theme,
      darkTheme: themes.darkTheme,
      themeMode: settings.themeMode,
      themeAnimationCurve: Curves.easeInOut,
      builder: builder,
      home: const BasedSplashPage(
        rootPage: RootPage(),
        appIcon: AppIcon(),
        appName: AppName(fontSize: 42),
      ),
      locale: settings.locale,
      localizationsDelegates: App.localizationsDelegates,
      supportedLocales: App.supportLanguages.keys,
    );
  }
}

class _ScrollBehavior extends CupertinoScrollBehavior {
  const _ScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child;

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
