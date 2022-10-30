import 'package:mercurius/index.dart';

class ProfileModel extends ChangeNotifier {
  static late SharedPreferences _preferences;
  Profile profile = Profile();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    DevTools.printLog('[001] 程序初始化中');
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getString('profile') == null) {
      _preferences.setString(
          'profile', jsonEncode(Profile()..themeMode = ThemeMode.system));
      DevTools.printLog('[002] 程序完全初次运行，创建 profile 为 ${jsonEncode(profile)}');
    }
    profile = Profile.fromJson(jsonDecode(_preferences.getString('profile')!));
    DevTools.printLog('[003] 程序初始化完毕，且 profile 为 ${jsonEncode(profile)}');
  }

  void changeProfile(Profile profile) async {
    DevTools.printLog('[004] 更改 profile 为 ${jsonEncode(this.profile)}');
    this.profile = profile;
    save();
    notifyListeners();
  }

  void save() async {
    _preferences.setString('profile', jsonEncode(profile));
    DevTools.printLog('[005] 保存 profile 为 ${jsonEncode(profile)}');
  }
}
