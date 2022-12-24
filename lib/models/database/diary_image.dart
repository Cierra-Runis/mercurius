import 'package:mercurius/index.dart';

part 'diary_image.g.dart';

@collection
class DiaryImage {
  /// 日进图片 `id`
  Id? id;

  /// 添加该日记图片的时间
  late DateTime dateTime;

  /// 引用该日记图片的日记列表
  @Backlink(to: 'diaryImages')
  final diaries = IsarLinks<Diary>();
}
