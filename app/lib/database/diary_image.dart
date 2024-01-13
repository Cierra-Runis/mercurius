import 'package:mercurius/index.dart';
part 'diary_image.g.dart';
part 'diary_image.freezed.dart';

@freezed
@Collection(ignore: {'copyWith'})
class DiaryImage with _$DiaryImage {
  const DiaryImage._();

  const factory DiaryImage({
    required int id,
    required String title,
    required List<int> data,
    required DateTime createDateTime,
  }) = _DiaryImage;

  factory DiaryImage.fromJson(Map<String, Object?> json) =>
      _$DiaryImageFromJson(json);

  @ignore
  Uint8List get uint8list => Uint8List.fromList(data);

  @ignore
  ImageProvider get provider => MemoryImage(uint8list);
}
