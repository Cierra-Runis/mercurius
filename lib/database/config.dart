import 'package:mercurius/index.dart';
part 'config.g.dart';

@collection
class Config {
  Config({
    this.themeMode = ThemeMode.system,
    this.buttonVibration = true,
  });

  Id id = 0;

  /// 主题模式 (不可为空)
  @enumerated
  ThemeMode themeMode;

  /// 按钮振动 (不可为空)
  bool buttonVibration;
}