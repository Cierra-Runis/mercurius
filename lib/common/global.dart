// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mercurius/models/index.dart';

class Global {
  static late SharedPreferences _preferences;
  static Profile profile = Profile();

  // 是否为 release 版
  static bool get isRelease => !const bool.fromEnvironment("dart.vm.product");

  //初始化全局信息
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _preferences = await SharedPreferences.getInstance();
    String? profileString = _preferences.getString("profile");

    if (profileString == null) {
      // 说明系统无 profile, 也即程序完完全全第一次运行
      // 无就初始化
      if (Global.isRelease) {
        print('[001]: 第一次运行');
      }
      profile.themeMode = ThemeMode.system;
      profile.cache = CacheConfig()
        ..enable = true
        ..maxAge = 3600
        ..maxCount = 100;
      saveProfile();
    } else {
      // 说明系统有 profile
      try {
        // 有就获取
        profile = Profile.fromJson(jsonDecode(profileString));
        if (Global.isRelease) {
          print('[002]: $profileString');
        }
      } catch (e) {
        if (Global.isRelease) {
          print('[003]: 解析失败');
        }
      }
    }

    // 初始化网络请求相关配置
    // MercuriusWebInt();
  }

  // 持久化 Profile 信息
  static saveProfile() => _preferences.setString(
        "profile",
        jsonEncode(
          profile.toJson(),
        ),
      );
}
