import 'package:mercurius/index.dart';

import 'dart:developer' as devtools show log;

/// [Mercurius] 是为简便操作而创建的类
class Mercurius {
  /// 程序名称
  static const String name = 'Mercurius';

  /// 数据库名
  static const String database = 'mercurius_database';

  /// 联系 url
  static const String contactUrl = 'https://github.com/Cierra-Runis/';

  /// 亮色模式下的颜色集
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0061A2), // 普通按钮前景色
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFADCFFF), // 浮动按钮背景色
    onPrimaryContainer: Color(0xFF001D36),
    secondary: Color(0xFF535F70),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD6E4F7),
    onSecondaryContainer: Color(0xFF0F1C2B),
    tertiary: Color(0xFF6A5778),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFF2DAFF),
    onTertiaryContainer: Color(0xFF251432),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFCFF), // 主要容器背景色
    onBackground: Color(0xFF1A1C1E),
    surface: Color(0xFFFDFCFF), // 标题栏和卡片背景颜色
    onSurface: Color(0xFF1A1C1E), // 最基础字体色
    surfaceVariant: Color(0xFFDFE2EB),
    onSurfaceVariant: Color(0xFF42474E),
    outline: Color(0x8A000000), // 下划线，选项小字，你记颜色
    onInverseSurface: Color(0xFFF1F0F4),
    inverseSurface: Color(0xFF2F3033),
    inversePrimary: Color(0xFF9DCAFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFDFCFF),
    outlineVariant: Color(0xFFC3C7CF),
    scrim: Color(0xFF000000),
  );

  /// 暗色模式下的颜色集
  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB787), // 普通按钮前景色
    onPrimary: Color(0xFF502400),
    primaryContainer: Color(0xFF363636), // 浮动按钮背景色
    onPrimaryContainer: Color(0xCCE1E1E1), // 浮动按钮前景色
    secondary: Color(0xFFE5BFA8),
    onSecondary: Color(0xFF422B1B),
    secondaryContainer: Color(0xFF5B4130),
    onSecondaryContainer: Color(0xFFFFDCC7),
    tertiary: Color(0xFFCACA93),
    onTertiary: Color(0xFF31320A),
    tertiaryContainer: Color(0xFF48491F),
    onTertiaryContainer: Color(0xFFE6E6AD),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF242424), // 主要容器背景色
    onBackground: Color(0xFFECE0DA),
    surface: Color(0xFF303030), // 标题栏和卡片背景颜色
    onSurface: Color(0xFFECE0DA), // 最基础字体色
    surfaceVariant: Color(0xFF52443C),
    onSurfaceVariant: Color(0xFFD7C3B8),
    outline: Color(0x8AFFFFFF), // 下划线，选项小字，你记颜色
    onInverseSurface: Color(0xFF201A17),
    inverseSurface: Color(0xFFECE0DA),
    inversePrimary: Color(0xFF964900),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF181818),
    outlineVariant: Color(0xFF303030),
    scrim: Color(0xFF000000),
  );

  static void run() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// 在 Windows 上启动窗口管理
    if (Platform.isWindows) {
      await PlatformWindowsManager.init();
      await PlatformWindowsTray.init();
    }

    /// 在 Android 上实现高刷
    if (Platform.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }

    /// 固定竖屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    /// 启动
    runApp(const ProviderScope(child: MercuriusApp()));
  }

  /// [Mercurius] 调试用输出语句
  static void printLog(String newLog) {
    devtools.log('[${Mercurius.name}] $newLog');
  }

  static void vibration({
    required WidgetRef ref,
    int duration = 50,
    List<int> pattern = const [],
    int repeat = -1,
    List<int> intensities = const [],
    int amplitude = -1,
  }) async {
    /// Windows 不支持振动
    if (Platform.isWindows) return;

    Config config = await isarService.getConfig();
    bool buttonVibration = config.buttonVibration;
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
