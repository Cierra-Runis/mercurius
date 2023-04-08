import 'package:mercurius/index.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  /// 当 profile.dart 添加新数据时
  /// 为了版本的迭代, 在此添加的新数据格式应该为
  /// <类型>? <变量名> [= <初始值>];
  /// 这里的初始值表明了他是不可为空但在旧版本数据为空

  /*
  语法	             含义
  纯文本	           纯文本，直接键入。
  <参数名>	         需要使用一合适的值来替换该函数。
  [可选项]	         该输入项是可选的。
  (输入项｜输入项)	  必须地在显示的值中选择一个填写。
  [输入项｜输入项]	  可选地在显示的值中选择一个填写。
  */

  /// 用户
  User? user;

  /// 用户 `token`
  String? token;

  /// 主题模式 (不可为空)
  ThemeMode? themeMode = ThemeMode.system;

  /// 按钮振动 (不可为空)
  bool? buttonVibration = true;

  /// 最后登录于
  String? lastLogin;

  /// 数独难度 (不可为空)
  String? sudokuDifficulty = '大师级';

  /// 当前版本
  String? currentVersion;

  /// 缓存的位置
  Cache cache = Cache();

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  static Profile getSaveProfile(Profile profile) {
    profile.themeMode ??= ThemeMode.system;
    profile.buttonVibration ??= true;
    profile.sudokuDifficulty ??= '大师级';
    return profile;
  }
}
