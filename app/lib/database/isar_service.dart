import 'package:mercurius/index.dart';

abstract class _Service {
  final Isar db;

  const _Service({required this.db});
}

class IsarService extends _Service with _DiaryService {
  const IsarService(Isar db) : super(db: db);

  Future<bool> importJsonWith(String path) async {
    try {
      final isar = db;
      final bytes = await File(path).readAsString();
      await isar.writeAsync((isar) {
        isar.diarys.clear();
        isar.diarys.importJsonString(bytes);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> exportDiaryJson() async {
    final isar = db;
    return isar.diarys.where().exportJson();
  }

  Future<void> cleanDb() async {
    final isar = db;
    await isar.writeAsync((isar) => isar.clear);
  }

  static IsarService openDB(Directory directory) {
    final isar = Isar.open(
      schemas: [
        DiarySchema,
      ],
      name: App.database,
      directory: directory.path,
      compactOnLaunch: const CompactCondition(
        minBytes: 1024,
        minFileSize: 1024,
      ),
    );

    return IsarService(isar);
  }
}

mixin _DiaryService on _Service {
  Future<void> saveDiary(Diary newDiary) async {
    final isar = db;
    return isar.writeAsync((isar) => isar.diarys.put(newDiary));
  }

  Future<List<Diary>> getDiaryByDate(DateTime dateTime) async {
    final isar = db;
    return isar.diarys
        .where()
        .createAtBetween(
          DateTime(dateTime.year, dateTime.month, dateTime.day),
          DateTime(dateTime.year, dateTime.month, dateTime.day).nextDay,
        )
        .findAll();
  }

  Stream<List<Diary>> listenToDiariesEditing() async* {
    final isar = db;
    yield* isar.diarys
        .where()
        .editingEqualTo(true)
        .watch(fireImmediately: true);
  }

  Future<List<Diary>> getAllDiaries() async {
    final isar = db;
    return isar.diarys.where().findAll();
  }

  Stream<List<Diary>> listenToAllDiaries() async* {
    final isar = db;
    yield* isar.diarys
        .where()
        .editingEqualTo(false)
        .sortByCreateAtDesc()
        .watch(fireImmediately: true);
  }

  Future<void> deleteDiaryById(int id) async {
    final isar = db;
    await isar.writeAsync((isar) => isar.diarys.delete(id));
  }
}
