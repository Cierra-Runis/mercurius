// ignore_for_file: non_constant_identifier_names

import 'package:mercurius/index.dart';

part 'hitokoto.g.dart';

@JsonSerializable()
class HiToKoTo {
  const HiToKoTo({
    required this.id,
    required this.uuid,
    required this.type,
    required this.from,
    required this.from_who,
    required this.creator,
    required this.creator_uid,
    required this.reviewer,
    required this.commit_from,
    required this.created_at,
    required this.length,
    required this.hitokoto,
  });

  final int? id;
  final String? uuid;
  final String hitokoto;
  final String? type;
  final String? from;
  final String? from_who;
  final String? creator;
  final int? creator_uid;
  final int? reviewer;
  final String? commit_from;
  final String? created_at;
  final int? length;

  factory HiToKoTo.fromJson(Map<String, dynamic> json) =>
      _$HiToKoToFromJson(json);
  Map<String, dynamic> toJson() => _$HiToKoToToJson(this);
}
