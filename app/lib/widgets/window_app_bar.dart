import 'package:mercurius/index.dart';

class WindowAppBar extends ConsumerWidget {
  const WindowAppBar({super.key});

  static const appBarHeight = 24.0;
  static const _actionSize = 16.0;
  static const _actionWidth = _actionSize * 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return GestureDetector(
      onDoubleTap: toggleMaximized,
      onPanStart: (details) => windowManager.startDragging(),
      child: AppBar(
        toolbarHeight: appBarHeight,
        title: const Text(
          App.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: setSettings.loopThemeMode,
            child: SizedBox(
              width: _actionWidth,
              height: appBarHeight,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  key: ValueKey(settings.themeMode),
                  App.themeModeIcon[settings.themeMode],
                  size: _actionSize,
                ),
              ),
            ),
          ),
          if (Platform.isWindows)
            InkWell(
              onTap: windowManager.minimize,
              child: const SizedBox(
                width: _actionWidth,
                height: appBarHeight,
                child: Icon(
                  Icons.remove_rounded,
                  size: _actionSize,
                ),
              ),
            ),
          if (Platform.isWindows)
            InkWell(
              /// TODO: based_snap_assist
              onHover: (value) => App.printLog('based_snap_assist'),
              onTap: toggleMaximized,
              child: const SizedBox(
                width: _actionWidth,
                height: appBarHeight,
                child: Icon(
                  Icons.fullscreen_rounded,
                  size: _actionSize,
                ),
              ),
            ),
          if (Platform.isWindows)
            InkWell(
              onTap: windowManager.close,
              hoverColor: Colors.red,
              child: const SizedBox(
                width: _actionWidth,
                height: appBarHeight,
                child: Icon(
                  Icons.close_rounded,
                  size: _actionSize,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void toggleMaximized() async => await windowManager.isMaximized()
      ? windowManager.unmaximize()
      : windowManager.maximize();
}
