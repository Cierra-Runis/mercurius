import 'package:mercurius/index.dart';

class MercuriusWindowsManager {
  static Future<void> init() async {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      title: Mercurius.name,
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () {
      windowManager.show();
      windowManager.focus();
    });
  }

  static List<Widget>? getActions() {
    if (Platform.isAndroid) return null;
    return [
      IconButton(
        onPressed: windowManager.minimize,
        icon: const Icon(
          UniconsLine.minus,
        ),
      ),
      IconButton(
        onPressed: () async {
          if (await windowManager.isMaximized()) {
            windowManager.unmaximize();
          } else {
            windowManager.maximize();
          }
        },
        icon: const Icon(
          Icons.crop_square_rounded,
        ),
      ),
      IconButton(
        onPressed: windowManager.hide,
        icon: const Icon(
          UniconsLine.times,
        ),
      )
    ];
  }
}
