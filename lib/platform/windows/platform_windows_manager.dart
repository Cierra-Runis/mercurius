import 'package:mercurius/index.dart';

class PlatformWindowsManager {
  static Future<void> init() async {
    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions(
      title: App.name,
      minimumSize: Size(400, 400),
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
        iconSize: 18,
        icon: const Icon(
          UniconsLine.minus,
        ),
      ),
      const IconButton(
        onPressed: switchMaximized,
        iconSize: 18,
        icon: Icon(
          Icons.crop_square_rounded,
        ),
      ),
      IconButton(
        onPressed: windowManager.hide,
        iconSize: 18,
        icon: const Icon(
          UniconsLine.times,
        ),
      ),
    ];
  }

  static void switchMaximized() async {
    if (await windowManager.isMaximized()) {
      windowManager.unmaximize();
    } else {
      windowManager.maximize();
    }
  }
}
