import 'package:mercurius/index.dart';

class MercuriusWindowsTray {
  static Future<void> init() async {
    final SystemTray systemTray = SystemTray();

    await systemTray.initSystemTray(
      title: Mercurius.name,
      toolTip: Mercurius.name,
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
