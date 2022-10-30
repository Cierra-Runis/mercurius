import 'dart:developer' as devtools show log;

class DevTools {
  static const isDevMode = true;
  static void printLog(String message) {
    if (isDevMode) {
      devtools.log(message);
    }
  }
}
