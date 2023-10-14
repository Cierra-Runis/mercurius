// ignore_for_file: non_constant_identifier_names

import 'package:mercurius/index.dart';

part 'hitokoto.g.dart';
part 'hitokoto.freezed.dart';

@freezed
class HiToKoTo with _$HiToKoTo {
  const factory HiToKoTo({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'uuid') required String uuid,
    @JsonKey(name: 'hitokoto') required String hitokoto,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'from') required String from,
    @JsonKey(name: 'from_who') required String fromWho,
    @JsonKey(name: 'creator') required String creator,
    @JsonKey(name: 'creator_uid') required int creatorUid,
    @JsonKey(name: 'reviewer') required int reviewer,
    @JsonKey(name: 'commit_from') required String commitFrom,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'length') required int length,
  }) = _HiToKoTo;

  const HiToKoTo._();

  factory HiToKoTo.fromJson(Map<String, Object?> json) =>
      _$HiToKoToFromJson(json);
}
