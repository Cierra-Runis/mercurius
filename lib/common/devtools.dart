import 'dart:developer' as devtools show log;
import 'package:mercurius/index.dart';

class DevTools {
  // 在这改设定
  static const showLog = true;
  static const showDebugPaintSizeEnabled = false;

  // 调试用输出语句
  static void printLog(String message) {
    if (showLog) {
      devtools.log(message);
    }
  }

  static void init() {
    // 是否启用边界显示
    debugPaintSizeEnabled = DevTools.showDebugPaintSizeEnabled;
  }
}
