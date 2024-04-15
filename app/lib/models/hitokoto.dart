import 'package:mercurius/index.dart';

part 'hitokoto.freezed.dart';
part 'hitokoto.g.dart';

@freezed
class HiToKoTo with _$HiToKoTo {
  const factory HiToKoTo({
    required String uuid,
    required String hitokoto,
  }) = _HiToKoTo;

  const HiToKoTo._();

  factory HiToKoTo.fromJson(Json json) => _$HiToKoToFromJson(json);
}
