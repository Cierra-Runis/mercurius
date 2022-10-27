import 'package:json_annotation/json_annotation.dart';

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
