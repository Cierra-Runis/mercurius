import 'package:mercurius/index.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User();

  num? mercuriusId;
  String? username;
  String? email;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
