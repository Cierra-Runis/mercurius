import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log, inspect;

late final IsarService isarService;

typedef Json = Map<String, dynamic>;

abstract class App {
  static const name = 'Mercurius';
  static const database = 'mercurius_database';
  static const fontSaira = 'Saira';
  static const fontCascadiaCodePL = 'CascadiaCodePL';
  static const fontMiSans = 'MiSans';

  static const githubUrl = 'https://github.com/Cierra-Runis';
  static const repoUrl = '$githubUrl/mercurius';
  static const openIssueUrl = '$repoUrl/issues/new/choose';
  static const thirdPartyLicenseUrl = '$repoUrl/wiki/Third-Party-License';
  static const privacyPolicyUrl = '$repoUrl/wiki/Privacy-Policy';

  static const themeModeIcon = {
    ThemeMode.system: Icons.brightness_auto_rounded,
    ThemeMode.light: Icons.light_mode_rounded,
    ThemeMode.dark: Icons.dark_mode_rounded,
  };

  static const supportLanguages = {
    'English': Locale('en'),
    '日本語': Locale('ja'),
    '中文': Locale('zh'),
  };

  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      if (Platform.isWindows || Platform.isMacOS) {
        await PlatformWindowManager.init();
      }

      if (Platform.isAndroid) {
        await FlutterDisplayMode.setHighRefreshRate();
      }

      final paths = await Paths.init();
      final persistence = await Persistence.init();
      final dynamicColor = await DynamicColor.init();
      final packageInfo = await PackageInfo.fromPlatform();

      isarService = IsarService.openDB(paths.appSupport);

      runApp(
        ProviderScope(
          observers: const [_ProviderObserver()],
          overrides: [
            pathsProvider.overrideWithValue(paths),
            persistenceProvider.overrideWithValue(persistence),
            dynamicColorProvider.overrideWithValue(dynamicColor),
            packageInfoProvider.overrideWithValue(packageInfo),
          ],
          child: const MainApp(),
        ),
      );
    } catch (e, s) {
      return runApp(
        ProviderScope(
          child: _ErrorApp(e: e, s: s),
        ),
      );
    }
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
    final hasVibrator = await Vibration.hasVibrator() ?? false;
    if (!hasVibrator) return;

    final hasAmplitudeControl = await Vibration.hasAmplitudeControl() ?? false;
    if (!hasAmplitudeControl) return;

    final hasCustomVibrationsSupport =
        await Vibration.hasCustomVibrationsSupport() ?? false;
    if (!hasCustomVibrationsSupport) return;

    try {
      await Vibration.vibrate(
        duration: duration,
        pattern: pattern,
        repeat: repeat,
        intensities: intensities,
        amplitude: amplitude,
      );
    } catch (e, s) {
      App.printLog('Vibration error', error: e, stackTrace: s);
    }
  }
}

class _ErrorApp extends StatelessWidget {
  const _ErrorApp({
    required this.e,
    required this.s,
  });

  final Object e;
  final StackTrace s;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Text('$e\n$s'),
        ),
      ),
    );
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
