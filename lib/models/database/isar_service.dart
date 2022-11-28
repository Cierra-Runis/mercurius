import 'package:mercurius/index.dart';

import 'package:dart_date/dart_date.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveDiary(Diary newDiary) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.diarys.putSync(newDiary));
  }

  Future<void> saveDiaryImage(DiaryImage newDiaryImage) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.diaryImages.putSync(newDiaryImage));
  }

  Stream<List<Diary>> listenToDiaries() async* {
    final isar = await db;
    yield* isar.diarys.where().watch(fireImmediately: true);
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<Diary>> getDiariesFor(DiaryImage diaryImage) async {
    final isar = await db;
    return await isar.diarys
        .filter()
        .diaryImages((q) => q.idEqualTo(diaryImage.id))
        .findAll();
  }

  Future<List<DiaryImage?>> getDiaryImagesFor(Diary diary) async {
    final isar = await db;

    return await isar.diaryImages
        .filter()
        .diaries((q) => q.idEqualTo(diary.id))
        .findAll();
  }

  Future<List<dynamic>> isDiaryExisted(DateTime dateTime) async {
    final isar = await db;

    List<Diary> diarys = isar.diarys.filter().idIsNotNull().findAllSync();
    DevTools.printLog(diarys.length.toString());
    for (var i in diarys) {
      if (DateTime.parse(i.createDateTime).isSameDay(dateTime)) {
        DevTools.printLog(
            '[052] 创建时间 ${DateTime.parse(i.createDateTime)} 与 点击按钮时间 $dateTime 已显示，已有日记');
        return [true, i];
      }
    }
    DevTools.printLog('[052] $dateTime 不含日记');
    return [false, null];
  }

  Future<Isar> openDB() async {
    DevTools.printLog('[047] 打开数据库中');

    if (Isar.instanceNames.isEmpty) {
      DevTools.printLog('[050] 现在所打开的数据库 ${{
        Isar.instanceNames
      }} 个数为零，打开 mercurius_database 中');
      return await Isar.open(
        [DiarySchema, DiaryImageSchema],
        inspector: true,
        name: 'mercurius_database',
      );
    }

    DevTools.printLog('[048] 打开数据库 ${{Isar.instanceNames}} 完毕');
    return Future.value(Isar.getInstance('mercurius_database'));
  }
}
