import 'dart:developer' as devtools show log, inspect;

import 'package:mercurius/index.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as launch1;
import 'package:url_launcher/url_launcher_string.dart' as launch2;

late final IsarService isarService;

typedef Json = Map<String, dynamic>;

abstract class App {
  static const name = 'Mercurius';
  static const database = 'mercurius_database';

  static const githubUrl = 'https://github.com/Cierra-Runis';
  static const repoUrl = '$githubUrl/mercurius';

  static const publicGitHubUrl =
      'https://raw.githubusercontent.com/Cierra-Runis';
  static const publicRepoUrl = '$publicGitHubUrl/Cierra-Runis';
  static const branch = 'main';

  static const openIssueUrl = '$repoUrl/issues/new/choose';
  static const thirdPartyLicenseUrl = '$repoUrl/wiki/Third-Party-License';
  static const privacyPolicyUrl = '$repoUrl/wiki/Privacy-Policy';

  /// [fontSaira] apply to [App.name]
  static const fontSaira = 'Saira';
  static const fontCascadiaCodePL = 'CascadiaCodePL';

  static const fontsFolderUrl = '$publicRepoUrl/$branch/public/fonts';
  static const fontsManifestUrl = '$fontsFolderUrl/fonts_manifest.json';

  static const aMapApiUrl = 'https://restapi.amap.com/v3/ip';
  static const aMapApiKey = String.fromEnvironment('aMapApiKey');

  static const qWeatherApiUrl = 'https://devapi.qweather.com/v7/weather/now';
  static const qWeatherApiKey = String.fromEnvironment('qWeatherApiKey');

  static const builtAt = String.fromEnvironment('builtAt');

  static final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 3),
      followRedirects: true,
      maxRedirects: 3,
    ),
  );

  static final splitViewKey = GlobalKey<NavigatorState>();

  static Future<void> showSnackBar(Widget content) async {
    final buildContext = splitViewKey.currentContext;
    if (buildContext == null) return;
    App.printLog(content);
    ScaffoldMessenger.of(buildContext).showSnackBar(
      SnackBar(content: content),
    );
  }

  static const themeModeIcon = {
    ThemeMode.system: Icons.brightness_auto_rounded,
    ThemeMode.light: Icons.light_mode_rounded,
    ThemeMode.dark: Icons.dark_mode_rounded,
  };

  static final supportLanguages = {
    /// TIPS: Use zh_CN as default locale
    /// See https://github.com/flutter/flutter/issues/103811#issuecomment-1199012026
    const Locale('zh', 'CN'): '简体中文',
    const Locale('en'): 'English',
    const Locale('ja'): '日本語',
  };

  static const localizationsDelegates = [
    L10N.delegate,
    ...FlutterQuillLocalizations.localizationsDelegates,
  ];

  static const fontSize6 = 6.0;
  static const fontSize8 = 8.0;
  static const fontSize10 = 10.0;
  static const fontSize12 = 12.0;
  static const fontSize16 = 16.0;
  static const fontSize18 = 18.0;
  static const fontSize20 = 20.0;
  static const fontSize24 = 24.0;
  static const fontSize42 = 42.0;

  /// The entry of [App].
  ///
  /// Initialize settings for different platforms,
  /// and override provider that need async initialization.
  ///
  /// If initialization failed, run [_ErrorApp] instead.
  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      if (!kDebugMode) debugPrint(details.toString());
    };

    try {
      if (Platform.isWindows || Platform.isMacOS) {
        await _PlatformWindowManager.init();
      }

      if (Platform.isAndroid) {
        await FlutterDisplayMode.setHighRefreshRate();
      }

      final paths = await Paths.init();
      final persistence = await Persistence.init();
      final dynamicColor = await DynamicColor.init();
      final packageInfo = await PackageInfo.fromPlatform();

      /// TODO: use riverpod instead
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
          child: const _MainApp(),
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
    debugPrint('$log');
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
      App.printLog('Vibrate Failed', error: e, stackTrace: s);
    }
  }

  static void launchUrl(
    dynamic url, {
    launch1.LaunchMode mode = launch1.LaunchMode.externalApplication,
    launch1.WebViewConfiguration webViewConfiguration =
        const launch1.WebViewConfiguration(),
    launch1.BrowserConfiguration browserConfiguration =
        const launch1.BrowserConfiguration(),
    String? webOnlyWindowName,
  }) async {
    if (url is Uri) {
      try {
        await launch1.launchUrl(
          url,
          mode: mode,
          webViewConfiguration: webViewConfiguration,
          browserConfiguration: browserConfiguration,
          webOnlyWindowName: webOnlyWindowName,
        );
      } catch (e, s) {
        printLog('Launch $url Failed', error: e, stackTrace: s);
      }
    }

    if (url is String) {
      try {
        await launch2.launchUrlString(
          url,
          mode: mode,
          webViewConfiguration: webViewConfiguration,
          browserConfiguration: browserConfiguration,
          webOnlyWindowName: webOnlyWindowName,
        );
      } catch (e, s) {
        printLog('Launch $url Failed', error: e, stackTrace: s);
      }
    }
  }

  static Future<void> shareUri(
    Uri uri, {
    Rect? sharePositionOrigin,
  }) async {
    try {
      await Share.shareUri(
        uri,
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e, s) {
      printLog('Share $uri Failed', error: e, stackTrace: s);
    }
  }

  static Future<void> share(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    if (text.isEmpty) return;
    try {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e, s) {
      printLog('Share $text Failed', error: e, stackTrace: s);
    }
  }

  static Future<void> shareXFiles(
    List<XFile> files, {
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
  }) async {
    if (files.isEmpty) return;
    try {
      await Share.shareXFiles(
        files,
        subject: subject,
        text: text,
        sharePositionOrigin: sharePositionOrigin,
      );
    } catch (e, s) {
      printLog('Share $files Failed', error: e, stackTrace: s);
    }
  }
}

/// https://riverpod.dev/docs/essentials/eager_initialization
class _MainApp extends ConsumerWidget {
  const _MainApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fontsLoaderProvider);
    return const MainApp();
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

abstract class _PlatformWindowManager {
  static Future<void> init() async {
    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions(
      title: App.name,
      minimumSize: Size(400, 400),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      windowButtonVisibility: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () {
      windowManager.show();
      windowManager.focus();
    });
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
