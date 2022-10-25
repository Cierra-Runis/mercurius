import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import "index.dart";
part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile();

  late User user;
  String? token;
  ThemeMode? themeMode;
  CacheConfig? cache;
  String? lastLogin;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
