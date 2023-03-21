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

  /// 创建 `Stream` 监听所有含有 `contains` 字符串的日记
  Stream<List<Diary>> listenToDiariesContains(String contains) async* {
    final isar = await db;
    await Future.delayed(const Duration(milliseconds: 500), () {});
    yield* isar.diarys
        .filter()
        .contentJsonStringContains(contains)
        .sortByCreateDateTimeDesc()
        .watch(fireImmediately: true);
  }

  /// 获取所有日记
  Future<List<Diary>> getAllDiaries() async {
    final isar = await db;
    return isar.diarys.filter().idIsNotNull().findAll();
  }

  /// 清除数据库
  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  /// 在 `dateTime` 是否含有日记, 有则返回 `diary`, 反之返回 `null`
  Future<Diary?> isDiaryExisted(DateTime dateTime) async {
    final isar = await db;

    List<Diary> diaries = isar.diarys.where().findAllSync();
    for (var diary in diaries) {
      if (diary.createDateTime.isSameDay(dateTime)) {
        DevTools.printLog(
          '创建时间 ${diary.createDateTime} 与 点击按钮时间 $dateTime 已显示，已有日记',
        );
        return diary;
      }
    }
    DevTools.printLog('$dateTime 不含日记');
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
    DevTools.printLog('打开数据库中');

    if (Isar.instanceNames.isEmpty) {
      DevTools.printLog(
          '现在所打开的数据库 ${Isar.instanceNames} 个数为零，打开 mercurius_database 中');
      return await Isar.open(
        [DiarySchema],
        inspector: true,
        name: 'mercurius_database',
        directory: mercuriusPathNotifier.path,
        compactOnLaunch: const CompactCondition(
          /// 只要压缩能减小 1KB 及以上的体积就进行压缩
          minBytes: 1024,
        ),
      );
    }

    DevTools.printLog('数据库 ${Isar.instanceNames} 已被打开');
    return Future.value(Isar.getInstance('mercurius_database'));
  }
}
