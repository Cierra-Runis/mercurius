import 'package:mercurius/index.dart';

class MercuriusProfileNotifier extends ChangeNotifier {
  static late SharedPreferences _preferences;
  Profile profile = Profile();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    MercuriusKit.printLog('程序初始化中');

    /// 进行调试工具的初始化
    MercuriusKit.init();

    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getString('profile') == null) {
      _preferences.setString('profile', jsonEncode(profile));
      MercuriusKit.printLog('程序完全初次运行，创建 profile 为 ${jsonEncode(profile)}');
    }

    profile = Profile.fromJson(jsonDecode(_preferences.getString('profile')!));

    /// 保障版本升级的数据迁移
    profile = Profile.getSaveProfile(profile);

    _packageInfo = await PackageInfo.fromPlatform();
    profile.currentVersion =
        'v${_packageInfo.version}+${_packageInfo.buildNumber}';

    MercuriusKit.printLog('程序初始化完毕，且 profile 为 ${jsonEncode(profile)}');
    _saveProfile();

    /// 进入 `mercuriusPositionNotifier` 的初始化
    mercuriusPositionNotifier.init();

    /// 进入 `mercuriusPathNotifier` 的初始化
    mercuriusPathNotifier.init();

    /// 实现高刷
    await FlutterDisplayMode.setHighRefreshRate();

    /// 固定竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void changeProfile(Profile profile) async {
    this.profile = profile;
    _saveProfile();
    notifyListeners();
    super.notifyListeners();
  }

  void _saveProfile() async {
    _preferences.setString('profile', jsonEncode(profile));
    MercuriusKit.printLog('保存 profile 为 ${jsonEncode(profile)}');
  }
}
