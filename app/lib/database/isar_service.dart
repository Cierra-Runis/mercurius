import 'package:mercurius/index.dart';

abstract class _IsarService {
  final Isar isar;

  const _IsarService({required this.isar});
}

class IsarService extends _IsarService with _DiaryService {
  const IsarService(Isar isar) : super(isar: isar);

  Future<bool> importJsonWith(String path) async {
    try {
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
    return isar.diarys.where().exportJson();
  }

  Future<void> cleanDb() async {
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
  int diarysAutoIncrement() => isar.diarys.autoIncrement();

  Future<void> saveDiary(Diary newDiary) async {
    return isar.writeAsync((isar) => isar.diarys.put(newDiary));
  }

  Stream<List<Diary>> listenDiariesBetween(DateTime start, DateTime end) {
    return isar.diarys
        .where()
        .belongToBetween(
          DateUtils.dateOnly(start),
          DateUtils.dateOnly(end),
        )
        .watch(fireImmediately: true);
  }

  Stream<List<Diary>> listenEditingDiaries() async* {
    yield* isar.diarys
        .where()
        .editingEqualTo(true)
        .watch(fireImmediately: true);
  }

  Stream<List<Diary>> listenAllDiaries([bool sortDesc = true]) async* {
    final unsorted = isar.diarys.where().editingEqualTo(false);
    final sorted =
        sortDesc ? unsorted.sortByBelongToDesc() : unsorted.sortByBelongTo();
    yield* sorted.watch(fireImmediately: true);
  }

  Future<List<Diary>> getAllDiaries() async {
    return isar.diarys.where().sortByBelongTo().findAll();
  }

  Future<void> deleteDiaryById(int id) async {
    await isar.writeAsync((isar) => isar.diarys.delete(id));
  }
}
