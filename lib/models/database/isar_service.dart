import 'package:mercurius/index.dart';

import 'package:dart_date/dart_date.dart';

class IsarService {
  late Future<Isar> db;

  /// 创建一个 `IsarService`
  IsarService() {
    db = openDB();
  }

  /// 保存 `newDiary` 至数据库
  Future<void> saveDiary(Diary newDiary) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.diarys.putSync(newDiary));
  }

  /// 保存 `newDiaryImage` 至数据库
  Future<void> saveDiaryImage(DiaryImage newDiaryImage) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.diaryImages.putSync(newDiaryImage));
  }

  /// 创建 `Stream` 监听所有日记
  Stream<List<Diary>> listenToDiaries() async* {
    final isar = await db;
    yield* isar.diarys
        .where()
        .sortByCreateDateTime()
        .watch(fireImmediately: true);
  }

  /// 清除数据库
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  /// 根据 `diaryImage` 寻找引用其的所有日记
  Future<List<Diary>> getDiariesFor(DiaryImage diaryImage) async {
    final isar = await db;
    return await isar.diarys
        .filter()
        .diaryImages((q) => q.idEqualTo(diaryImage.id))
        .findAll();
  }

  /// 根据 `diary` 寻找其引用的所有日记图片
  Future<List<DiaryImage?>> getDiaryImagesFor(Diary diary) async {
    final isar = await db;

    return await isar.diaryImages
        .filter()
        .diaries((q) => q.idEqualTo(diary.id))
        .findAll();
  }

  /// 在 `dateTime` 是否含有日记, 有则返回 `diary`, 反之返回 `null`
  Future<Diary?> isDiaryExisted(DateTime dateTime) async {
    final isar = await db;

    List<Diary> diaries = isar.diarys.where().findAllSync();
    for (var diary in diaries) {
      if (diary.createDateTime.isSameDay(dateTime)) {
        DevTools.printLog(
          '[052] 创建时间 ${diary.createDateTime} 与 点击按钮时间 $dateTime 已显示，已有日记',
        );
        return diary;
      }
    }
    DevTools.printLog('[052] $dateTime 不含日记');
    return null;
  }

  /// 根据 `id` 删除日记
  Future<void> deleteDiaryById(int id) async {
    final isar = await db;

    await isar.writeTxn(() async {
      final success = await isar.diarys.delete(id);
      DevTools.printLog('日记删除情况 $success');
    });
  }

  /// 打开数据库
  Future<Isar> openDB() async {
    DevTools.printLog('[047] 打开数据库中');

    if (Isar.instanceNames.isEmpty) {
      DevTools.printLog(
          '[050] 现在所打开的数据库 ${Isar.instanceNames} 个数为零，打开 mercurius_database 中');
      return await Isar.open(
        [DiarySchema, DiaryImageSchema],
        inspector: true,
        name: 'mercurius_database',
      );
    }

    DevTools.printLog('[048] 打开数据库 ${Isar.instanceNames} 完毕');
    return Future.value(Isar.getInstance('mercurius_database'));
  }
}
