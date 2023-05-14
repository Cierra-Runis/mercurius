import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'isar_service.g.dart';

@riverpod
class IsarService extends _$IsarService {
  late Future<Isar> _db;

  /// 创建一个 `IsarService`
  @override
  void build() => _db = openDB();

  /// 保存 `newDiary` 至数据库
  Future<void> saveDiary(Diary newDiary) async {
    final isar = await _db;
    isar.writeTxnSync<int>(() => isar.diarys.putSync(newDiary));
  }

  /// 创建 `Stream` 监听所有含有 `contains` 字符串的日记
  Stream<List<Diary>> listenToDiariesContains(
    String contains, {
    int delayed = 300,
  }) async* {
    final isar = await _db;
    await Future.delayed(Duration(milliseconds: delayed));
    yield* isar.diarys
        .filter()
        .contentJsonStringContains(contains)
        .sortByCreateDateTimeDesc()
        .watch(fireImmediately: true);
  }

  /// 获取所有日记
  Future<List<Diary>> getAllDiaries() async {
    final isar = await _db;
    return isar.diarys.where().findAll();
  }

  /// 清除数据库
  Future<void> cleanDb() async {
    final isar = await _db;
    await isar.writeTxn(() => isar.clear());
  }

  /// 根据 `id` 删除日记
  Future<void> deleteDiaryById(int id) async {
    final isar = await _db;
    await isar.writeTxn(() => isar.diarys.delete(id));
  }

  /// 导入 `json` 数据
  Future<void> importJsonWith(String path) async {
    final isar = await _db;
    final bytes = await File(path).readAsBytes();

    try {
      await isar.writeTxn(() async {
        await isar.diarys.clear();
        await isar.diarys.importJsonRaw(bytes);
      });
    } catch (e) {
      MercuriusKit.printLog('导入 json 文件出错：$e');
    }
  }

  /// 导出 `json` 数据
  Future<void> exportJsonWith(String path) async {
    final isar = await _db;
    List<Map<String, dynamic>> data = await isar.diarys.where().exportJson();
    File file = await File(path).create();
    await file.writeAsString(jsonEncode(data));
  }

  /// 打开数据库
  Future<Isar> openDB() async {
    MercuriusKit.printLog('数据库初始化中');

    if (Isar.instanceNames.isEmpty) {
      MercuriusKit.printLog(
        '现在所打开的数据库 ${Isar.instanceNames} 个数为零，打开 ${MercuriusConstance.database} 中',
      );
      final path = await ref.watch(mercuriusPathProvider.future);
      MercuriusKit.printLog('数据库初始化完成');
      return Isar.open(
        [DiarySchema],
        inspector: true,
        name: MercuriusConstance.database,
        directory: path,
        compactOnLaunch: const CompactCondition(
          /// 压缩能减小 1KB 及以上，且达到了 1KB 的体积就进行压缩
          minBytes: 1024,
          minFileSize: 1024,
        ),
      );
    }
    MercuriusKit.printLog('数据库 ${Isar.instanceNames} 已被打开');
    return Future.value(Isar.getInstance(MercuriusConstance.database));
  }
}
