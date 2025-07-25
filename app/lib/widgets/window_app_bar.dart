import 'package:mercurius/index.dart';

class WindowAppBar extends StatelessWidget {
  static const appBarHeight = 24.0;

  static const actionSize = 16.0;
  static const actionWidth = actionSize * 2;
  const WindowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: windowManager.center,
      onDoubleTap: _MaximizeButton.toggleMaximized,
      onPanStart: (details) => windowManager.startDragging(),
      child: AppBar(
        toolbarHeight: appBarHeight,
        title: const Text(
          App.name,
          style: TextStyle(
            fontSize: App.fontSize16,
            fontFamily: App.fontSaira,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          _LoopThemeModeButton(),
          _AlwaysOnTopButton(),
          _MinimizeButton(),
          _MaximizeButton(),
          _CloseButton(),
        ],
      ),
    );
  }
}

class _AlwaysOnTopButton extends HookWidget {
  const _AlwaysOnTopButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final snapshot = useFuture(windowManager.isAlwaysOnTop());
    final isAlwaysOnTop = snapshot.data ?? false;

    return InkWell(
      onTap: () async => windowManager.setAlwaysOnTop(
        !await windowManager.isAlwaysOnTop(),
      ),
      child: SizedBox(
        width: WindowAppBar.actionWidth,
        height: WindowAppBar.appBarHeight,
        child: Icon(
          Icons.push_pin_rounded,
          size: WindowAppBar.actionSize,
          color: isAlwaysOnTop ? colorScheme.error : null,
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: windowManager.close,
      hoverColor: Colors.red,
      child: const SizedBox(
        width: WindowAppBar.actionWidth,
        height: WindowAppBar.appBarHeight,
        child: Icon(
          Icons.close_rounded,
          size: WindowAppBar.actionSize,
        ),
      ),
    );
  }
}

class _LoopThemeModeButton extends ConsumerWidget {
  const _LoopThemeModeButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return InkWell(
      onTap: setSettings.loopThemeMode,
      child: SizedBox(
        width: WindowAppBar.actionWidth,
        height: WindowAppBar.appBarHeight,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            key: ValueKey(settings.themeMode),
            App.themeModeIcon[settings.themeMode],
            size: WindowAppBar.actionSize,
          ),
        ),
      ),
    );
  }
}

class _MaximizeButton extends StatelessWidget {
  const _MaximizeButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleMaximized,
      child: const SizedBox(
        width: WindowAppBar.actionWidth,
        height: WindowAppBar.appBarHeight,
        child: Icon(
          Icons.fullscreen_rounded,
          size: WindowAppBar.actionSize,
        ),
      ),
    );
  }

  static void toggleMaximized() async => await windowManager.isMaximized()
      ? windowManager.unmaximize()
      : windowManager.maximize();
}

class _MinimizeButton extends StatelessWidget {
  const _MinimizeButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: windowManager.minimize,
      child: const SizedBox(
        width: WindowAppBar.actionWidth,
        height: WindowAppBar.appBarHeight,
        child: Icon(
          Icons.remove_rounded,
          size: WindowAppBar.actionSize,
        ),
      ),
    );
  }
}
