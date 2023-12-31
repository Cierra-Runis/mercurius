import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log, inspect;

abstract class App {
  static const name = 'Mercurius';
  static const database = 'mercurius_database';
  static const contactUrl = 'https://github.com/Cierra-Runis/';
  static const fontSaira = 'Saira';
  static const fontCascadiaCodePL = 'CascadiaCodePL';
  static const fontMiSans = 'MiSans';

  static const themeModeIcon = {
    ThemeMode.system: Icons.brightness_auto_rounded,
    ThemeMode.light: Icons.light_mode_rounded,
    ThemeMode.dark: Icons.dark_mode_rounded,
  };

  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWindows || Platform.isMacOS) {
      await PlatformWindowsManager.init();
    }

    if (Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    runApp(
      ProviderScope(
        observers: const [_ProviderObserver()],
        overrides: [
          persistenceProvider.overrideWithValue(
            await Persistence.init(),
          ),
          colorSchemesProvider.overrideWithValue(
            await ColorSchemes.init(),
          ),
          packageInfoProvider.overrideWithValue(
            await PackageInfo.fromPlatform(),
          ),
        ],
        child: const MercuriusApp(),
      ),
    );
  }

  static void printLog(
    dynamic log, {
    Object? inspect,
    Object? error,
    StackTrace? stackTrace,
  }) {
    devtools.log(
      '$log',
      name: name,
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
    if (inspect != null) devtools.inspect(inspect);
  }

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

class _Inspect {
  const _Inspect({
    required this.provider,
    required this.container,
    this.value,
    this.previousValue,
    this.newValue,
  });
  final ProviderBase<Object?> provider;
  final Object? value;
  final Object? previousValue;
  final Object? newValue;
  final ProviderContainer container;
}

class _ProviderObserver extends ProviderObserver {
  /// An object that listens to the changes of a [ProviderContainer].
  ///
  /// This can be used for logging or making devtools.
  const _ProviderObserver();

  /// A provider was initialized, and the value exposed is [value].
  ///
  /// [value] will be `null` if the provider threw during initialization.
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) =>
      App.printLog(
        'didAddProvider: ${provider.name}',
        inspect: _Inspect(
          provider: provider,
          value: value,
          container: container,
        ),
      );

  /// A provider emitted an error, be it by throwing during initialization
  /// or by having a [Future]/[Stream] emit an error
  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) =>
      App.printLog(
        'providerDidFail: ${provider.name}',
        error: error,
        stackTrace: stackTrace,
        inspect: _Inspect(
          provider: provider,
          container: container,
        ),
      );

  /// Called by providers when they emit a notification.
  ///
  /// - [newValue] will be `null` if the provider threw during initialization.
  /// - [previousValue] will be `null` if the previous build threw during initialization.
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) =>
      App.printLog(
        'didUpdateProvider: ${provider.name}',
        inspect: _Inspect(
          provider: provider,
          container: container,
          previousValue: previousValue,
          newValue: newValue,
        ),
      );

  /// A provider was disposed
  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) =>
      App.printLog(
        'didDisposeProvider: ${provider.name}',
        inspect: _Inspect(
          provider: provider,
          container: container,
        ),
      );
}
