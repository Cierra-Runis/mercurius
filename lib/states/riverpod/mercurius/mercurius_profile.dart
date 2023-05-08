import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mercurius_profile.g.dart';

@riverpod
class MercuriusProfile extends _$MercuriusProfile {
  @override
  Future<Profile> build() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// 实现高刷
    await FlutterDisplayMode.setHighRefreshRate();

    /// 固定竖屏
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Profile profile = Profile();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    MercuriusKit.printLog('MercuriusProfile 初始化中');
    PackageInfo packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
    );

    preferences = await SharedPreferences.getInstance();
    if (preferences.getString('profile') == null) {
      preferences.setString('profile', jsonEncode(profile));
      MercuriusKit.printLog(
          'MercuriusProfile 完全初次运行，创建 profile 为 ${jsonEncode(profile)}');
    }

    profile = Profile.fromJson(jsonDecode(preferences.getString('profile')!));

    /// 保障版本升级的数据迁移
    profile = Profile.getSaveProfile(profile);

    packageInfo = await PackageInfo.fromPlatform();
    profile.currentVersion =
        'v${packageInfo.version}+${packageInfo.buildNumber}';

    MercuriusKit.printLog(
      'MercuriusProfile 初始化完毕，且 profile 为 ${jsonEncode(profile)}',
    );

    /// TIPS: 启用这里的 10s 延迟会有很多 “有趣的事情” 发生
    /// TIPS: 这要求我们读取 profile 的速度要足够快
    // await Future.delayed(const Duration(seconds: 10));

    return profile;
  }

  Future<void> changeProfile(Profile profile) async {
    state = const AsyncValue.loading();
    await _saveProfile(profile);
    state = await AsyncValue.guard(() async => profile);
  }

  Future<void> _saveProfile(Profile profile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('profile', jsonEncode(profile));
    MercuriusKit.printLog('保存 profile 为 ${jsonEncode(profile)}');
  }
}
