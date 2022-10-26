import 'package:flutter/material.dart';

import 'package:mercurius/common/index.dart';
import 'package:mercurius/models/index.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存 Profile 变更
    super.notifyListeners(); //通知依赖的 Widget 更新
  }
}

class UserModel extends ProfileChangeNotifier {
  User? get user => _profile.user;

  set user(User? user) {
    if (this.user != user) {
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  ThemeMode? get themeMode => _profile.themeMode;

  // 主题改变后，通知其依赖项，新主题会立即生效
  set themeMode(ThemeMode? themeMode) {
    if (this.themeMode != themeMode) {
      _profile.themeMode = themeMode;
      notifyListeners();
    }
  }
}
