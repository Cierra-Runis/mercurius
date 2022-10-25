import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mercurius/models/index.dart';

class Global {
  static late SharedPreferences _preferences;
  static Profile profile = Profile();

  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  //初始化全局信息
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _preferences = await SharedPreferences.getInstance();
    String? profileString = _preferences.getString("profile");
    Profile? profile;
    if (profileString != null) {
      try {
        profile = Profile.fromJson(jsonDecode(profileString));
      } catch (e) {
        // print(e);
      }
    }

    profile?.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    // 如果没有缓存策略，设置默认缓存策略

    // 初始化网络请求相关配置
    // MercuriusWebInt();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _preferences.setString("profile", jsonEncode(profile.toJson()));
}
