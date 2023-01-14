import 'package:mercurius/index.dart';

class ProfileModel extends ChangeNotifier {
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
    DevTools.printLog('程序初始化中');
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getString('profile') == null) {
      _preferences.setString(
          'profile', jsonEncode(Profile()..themeMode = ThemeMode.system));
      DevTools.printLog('程序完全初次运行，创建 profile 为 ${jsonEncode(profile)}');
    }
    profile = Profile.fromJson(jsonDecode(_preferences.getString('profile')!));

    _packageInfo = await PackageInfo.fromPlatform();
    profile.currentVersion =
        'v${_packageInfo.version}+${_packageInfo.buildNumber}';

    DevTools.printLog('程序初始化完毕，且 profile 为 ${jsonEncode(profile)}');
    save();

    /// 进入 `mercuriusWebModel` 的初始化
    mercuriusWebModel.init();

    /// 进入 `positionModel` 的初始化
    positionModel.init();

    /// 进入 `pathModel` 的初始化
    pathModel.init();

    /// 实现高刷
    await FlutterDisplayMode.setHighRefreshRate();

    // 进行调试工具的初始化
    DevTools.init();
  }

  void changeProfile(Profile profile) async {
    DevTools.printLog('更改 profile 为 ${jsonEncode(this.profile)}');
    this.profile = profile;
    save();
    notifyListeners();
    super.notifyListeners();
  }

  void save() async {
    _preferences.setString('profile', jsonEncode(profile));
    DevTools.printLog('保存 profile 为 ${jsonEncode(profile)}');
  }
}
