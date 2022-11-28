import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log;

class DevTools {
  // 在这改设定
  static const showLog = true;
  static const showDebugPaintSizeEnabled = false;

  // 一些开发者信息
  static String weatherKey = 'a13fc8e191d14cc0930bc07c6660d900';

  // 调试用输出语句
  static void printLog(String message) {
    if (showLog) {
      devtools.log(message);
      logModel.addLog('$message\n');
    }
  }

  static void init() {
    // 是否启用边界显示
    debugPaintSizeEnabled = DevTools.showDebugPaintSizeEnabled;
  }
}
