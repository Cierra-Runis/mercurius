import 'package:mercurius/index.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  /// Mercurius Id
  num? mercuriusId;

  /// 用户名
  String? username;

  /// 邮箱
  String? email;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
