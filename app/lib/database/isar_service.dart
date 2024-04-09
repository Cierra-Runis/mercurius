import 'package:mercurius/index.dart';

abstract class _IsarService {
  final Isar db;

  const _IsarService({required this.db});
}

class IsarService extends _IsarService with _DiaryService {
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

  Future<List<Json>> exportDiaryJson() async {
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

mixin _DiaryService on _IsarService {
  int diarysAutoIncrement() => db.diarys.autoIncrement();

  Future<void> saveDiary(Diary newDiary) async {
    final isar = db;
    return isar.writeAsync((isar) => isar.diarys.put(newDiary));
  }

  Stream<List<Diary>> listenToDiariesWithDate(DateTime dateTime) {
    final isar = db;
    return isar.diarys
        .where()
        .belongToBetween(
          DateTime(dateTime.year, dateTime.month, dateTime.day),
          DateTime(dateTime.year, dateTime.month, dateTime.day)
              .nextDay
              .subSeconds(1),
        )
        .watch(fireImmediately: true);
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
    return isar.diarys.where().sortByBelongTo().findAll();
  }

  Stream<List<Diary>> listenToAllDiaries() async* {
    final isar = db;
    yield* isar.diarys
        .where()
        .editingEqualTo(false)
        .sortByBelongToDesc()
        .watch(fireImmediately: true);
  }

  Future<void> deleteDiaryById(int id) async {
    final isar = db;
    await isar.writeAsync((isar) => isar.diarys.delete(id));
  }
}
