import 'package:mercurius/index.dart';

class PlatformWindowsTray {
  static Future<void> init() async {
    final systemTray = SystemTray();

    await systemTray.initSystemTray(
      title: Mercurius.appName,
      toolTip: Mercurius.appName,
      iconPath: 'assets/icon/app_icon.ico',
    );

    systemTray.registerSystemTrayEventHandler((eventName) async {
      Mercurius.printLog('托盘点击事件为 $eventName');
      if (eventName == kSystemTrayEventClick) {
        if (await windowManager.isVisible()) {
          windowManager.hide();
        } else {
          windowManager.show();
        }
      }
    });
  }
}
