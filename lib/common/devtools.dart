import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log;

class DevTools {
  /// 是否显示日志
  static const showLog = true;

  /// 是否显示边界
  static const showDebugPaintSizeEnabled = false;

  /// 调试用输出语句
  static void printLog(String message) {
    if (showLog) {
      message = '[${DateTime.now()}] $message';
      devtools.log(message);
      logModel.addLog('$message\n');
    }
  }

  static void init() {
    /// 是否启用边界显示
    debugPaintSizeEnabled = DevTools.showDebugPaintSizeEnabled;
  }
}
