import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log;

class DevTools {
  /// 是否显示日志
  static const _showLog = true;

  /// 是否显示边界
  static const _showDebugPaintSizeEnabled = false;

  /// 调试用输出语句
  static void printLog(String message) {
    if (_showLog) {
      devtools.log(message);
      logModel.addLog('$message\n');
    }
  }

  static void init() {
    /// 是否启用边界显示
    debugPaintSizeEnabled = DevTools._showDebugPaintSizeEnabled;
  }
}
