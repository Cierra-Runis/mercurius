import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log;

/// [MercuriusKit] 是为简便操作而创建的类
class MercuriusKit {
  /// [MercuriusKit] 的振动方法
  static void vibration({
    int duration = 50,
    List<int> pattern = const [],
    int repeat = -1,
    List<int> intensities = const [],
    int amplitude = -1,
  }) async {
    /// TODO: vibration
    bool buttonVibration = true ?? false;
    bool hasVibrator = await Vibration.hasVibrator() ?? false;
    bool hasAmplitudeControl = await Vibration.hasAmplitudeControl() ?? false;
    bool hasCustomVibrationsSupport =
        await Vibration.hasCustomVibrationsSupport() ?? false;

    if (buttonVibration &&
        hasVibrator &&
        hasAmplitudeControl &&
        hasCustomVibrationsSupport) {
      Vibration.vibrate(
        duration: duration,
        pattern: pattern,
        repeat: repeat,
        intensities: intensities,
        amplitude: amplitude,
      );
    }
  }

  /// [MercuriusKit] 调试用输出语句
  static void printLog(String newLog) {
    devtools.log('[${MercuriusConstance.name}] $newLog');
  }
}
