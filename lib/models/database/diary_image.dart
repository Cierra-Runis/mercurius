import 'package:mercurius/index.dart';

part 'diary_image.g.dart';

@collection
class DiaryImage {
  Id? id;

  late DateTime dateTime;

  @Backlink(to: 'diaryImages')
  final diaries = IsarLinks<Diary>();
}
