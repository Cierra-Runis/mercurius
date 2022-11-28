// ignore_for_file: non_constant_identifier_names

import 'package:mercurius/index.dart';

part 'hitokoto.g.dart';

@JsonSerializable()
class HiToKoTo {
  HiToKoTo();

  int? id;
  String? uuid;
  late String hitokoto;
  String? type;
  String? from;
  String? from_who;
  String? creator;
  int? creator_uid;
  int? reviewer;
  String? commit_from;
  String? created_at;
  int? length;

  factory HiToKoTo.fromJson(Map<String, dynamic> json) =>
      _$HiToKoToFromJson(json);
  Map<String, dynamic> toJson() => _$HiToKoToToJson(this);
}
