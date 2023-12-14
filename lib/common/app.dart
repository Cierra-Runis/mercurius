import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log;

abstract class App {
  static const name = 'Mercurius';
  static const database = 'mercurius_database';
  static const contactUrl = 'https://github.com/Cierra-Runis/';
  static const fontSaira = 'Saira';
  static const fontCascadiaCodePL = 'CascadiaCodePL';
  static const fontMiSans = 'MiSans';

  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows) {
      await PlatformWindowsManager.init();
      await PlatformWindowsTray.init();
    }

    if (Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    runApp(
      ProviderScope(
        overrides: [
          persistenceProvider.overrideWithValue(
            await Persistence.init(),
          ),
          colorSchemesProvider.overrideWithValue(
            await ColorSchemes.init(),
          ),
        ],
        child: const MercuriusApp(),
      ),
    );
  }

  static void printLog(dynamic log) =>
      devtools.log('$log', name: name, time: DateTime.now());

  static void vibration({
    int duration = 300,
    List<int> pattern = const [],
    int repeat = -1,
    List<int> intensities = const [],
    int amplitude = -1,
  }) async {
    if (!Platform.isAndroid) return;

    final hasVibrator = await Vibration.hasVibrator() ?? false;
    final hasAmplitudeControl = await Vibration.hasAmplitudeControl() ?? false;
    final hasCustomVibrationsSupport =
        await Vibration.hasCustomVibrationsSupport() ?? false;

    if (hasVibrator && hasAmplitudeControl && hasCustomVibrationsSupport) {
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
