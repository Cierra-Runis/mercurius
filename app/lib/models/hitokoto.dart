// ignore_for_file: non_constant_identifier_names

import 'package:mercurius/index.dart';

part 'hitokoto.g.dart';
part 'hitokoto.freezed.dart';

@freezed
class HiToKoTo with _$HiToKoTo {
  const factory HiToKoTo({
    required String uuid,
    required String hitokoto,
  }) = _HiToKoTo;

  const HiToKoTo._();

  factory HiToKoTo.fromJson(Map<String, Object?> json) =>
      _$HiToKoToFromJson(json);
}
