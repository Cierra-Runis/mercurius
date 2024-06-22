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

    final fontFamily = ref.watch(
      settingsProvider.select((value) => value.fontFamily),
    );
    final themeMode = ref.watch(
      settingsProvider.select((value) => value.themeMode),
    );
    final locale = ref.watch(
      settingsProvider.select((value) => value.locale),
    );

    final themes = colorSchemes.toThemes(fontFamily);

    return MaterialApp(
      scrollBehavior: const _ScrollBehavior(),
      theme: themes.theme,
      darkTheme: themes.darkTheme,
      themeMode: themeMode,
      themeAnimationCurve: Curves.easeInOut,
      builder: builder,
      home: const BasedSplashPage(
        rootPage: RootPage(),
        appIcon: AppIcon(),
        appName: AppName(fontSize: App.fontSize42),
      ),
      locale: locale,
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
