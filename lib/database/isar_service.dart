import 'package:mercurius/index.dart';

class IsarService {
  late Future<Isar> _db;

  /// 创建一个 `IsarService`
  IsarService() {
    _db = openDB();
  }

  /// 保存 `newDiary` 至数据库
  Future<int> saveDiary(Diary newDiary) async {
    final isar = await _db;
    return isar.writeTxn(() => isar.diarys.put(newDiary));
  }

  Future<List<Diary>> getDiaryByDate(DateTime dateTime) async {
    final isar = await _db;
    return isar.diarys
        .filter()
        .createDateTimeBetween(
          DateTime(dateTime.year, dateTime.month, dateTime.day),
          DateTime(dateTime.year, dateTime.month, dateTime.day).nextDay,
          includeUpper: false,
        )
        .findAll();
  }

  /// 创建 `Stream` 监听所有含有 `contains` 字符串的日记
  // Stream<List<Diary>> listenToDiariesContains(
  //   DiarySearch diarySearch, {
  //   int delayed = 300,
  // }) async* {
  //   final isar = await _db;
  //   await Future.delayed(Duration(milliseconds: delayed));
  //   QueryBuilder<Diary, Diary, QAfterFilterCondition> diaries =
  //       isar.diarys.filter().editingEqualTo(false);

  //   if (diarySearch.searchTitle) {
  //     diaries = diaries.titleStringContains(diarySearch.text);
  //   } else {
  //     diaries = diaries.contentJsonStringContains(diarySearch.text);
  //   }

  //   yield* diaries.sortByCreateDateTimeDesc().watch(fireImmediately: true);
  // }

  /// 创建 `Stream` 监听所有 `editing` 为 `true` 的日记
  Stream<List<Diary>> listenToDiariesEditing() async* {
    final isar = await _db;
    yield* isar.diarys
        .filter()
        .editingEqualTo(true)
        .watch(fireImmediately: true);
  }

  /// 获取所有日记
  Future<List<Diary>> getAllDiaries() async {
    final isar = await _db;
    return isar.diarys.where().findAll();
  }

  /// 监听所有非编辑中的日记
  Stream<List<Diary>> listenToAllDiaries() async* {
    final isar = await _db;
    yield* isar.diarys
        .filter()
        .editingEqualTo(false)
        .sortByCreateDateTimeDesc()
        .watch(fireImmediately: true);
  }

  /// 根据 `id` 删除日记
  Future<void> deleteDiaryById(int id) async {
    final isar = await _db;
    await isar.writeTxn(() => isar.diarys.delete(id));
  }

  /// 导入 `json` 数据
  Future<bool> importJsonWith(String path) async {
    try {
      final isar = await _db;
      final bytes = await File(path).readAsBytes();
      await isar.writeTxn(() async {
        await isar.diarys.clear();
        await isar.diarys.importJsonRaw(bytes);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 导出 `json` 数据
  Future<void> exportJsonWith(String path) async {
    final isar = await _db;
    final data = await isar.diarys.where().exportJson();
    final file = await File(path).create();
    await file.writeAsString(jsonEncode(data));
  }

  /// 清除数据库
  Future<void> cleanDb() async {
    final isar = await _db;
    await isar.writeTxn(isar.clear);
  }

  /// 打开数据库
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      Directory directory;

      /// TIPS: 对 Android 而言为 /data/user/0/Android/data/pers.cierra_runis.mercurius/files
      /// TIPS: 对 Windows 而言为 C:\Users\{user_name}\Documents/Mercurius/
      if (Platform.isAndroid) {
        directory = await getApplicationDocumentsDirectory();
      } else if (Platform.isWindows) {
        directory = await getApplicationDocumentsDirectory();
        final dir = Directory('${directory.path}/${Mercurius.appName}/');
        dir.createSync(recursive: true);
        directory = dir;
      } else {
        throw Exception('Unsupported Platform');
      }

      final isar = await Isar.open(
        [DiarySchema],
        inspector: true,
        name: Mercurius.database,
        directory: directory.path,
        compactOnLaunch: const CompactCondition(
          /// 压缩能减小 1KB 及以上，且达到了 1KB 的体积就进行压缩
          minBytes: 1024,
          minFileSize: 1024,
        ),
      );

      await DatabaseMigrator.migration(isar);

      return isar;
    }
    return Future.value(Isar.getInstance(Mercurius.database));
  }
}
