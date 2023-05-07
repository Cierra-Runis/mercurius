import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mercurius_profile.g.dart';

@riverpod
class MercuriusProfile extends _$MercuriusProfile {
  late SharedPreferences _preferences;

  @override
  Future<Profile> build() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// 实现高刷
    await FlutterDisplayMode.setHighRefreshRate();

    /// 固定竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Profile profile = Profile();

    MercuriusKit.printLog('程序初始化中');
    PackageInfo packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
    );

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

    packageInfo = await PackageInfo.fromPlatform();
    profile.currentVersion =
        'v${packageInfo.version}+${packageInfo.buildNumber}';

    MercuriusKit.printLog('程序初始化完毕，且 profile 为 ${jsonEncode(profile)}');

    return profile;
  }

  Future<void> changeProfile(Profile profile) async {
    state = const AsyncValue.loading();
    await _saveProfile(profile);
    state = await AsyncValue.guard(() async => profile);
  }

  Future<void> _saveProfile(Profile profile) async {
    _preferences.setString('profile', jsonEncode(profile));
    MercuriusKit.printLog('保存 profile 为 ${jsonEncode(profile)}');
  }
}
