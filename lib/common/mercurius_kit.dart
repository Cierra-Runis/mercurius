import 'package:mercurius/index.dart';

class MercuriusKit {
  /// [MercuriusKit] 的振动方法
  static void vibration({
    int duration = 50,
    List<int> pattern = const [],
    int repeat = -1,
    List<int> intensities = const [],
    int amplitude = -1,
  }) async {
    bool buttonVibration =
        mercuriusProfileNotifier.profile.buttonVibration ?? false;
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
}
