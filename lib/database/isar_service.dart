import 'package:mercurius/index.dart';

abstract class _Service {
  late Future<Isar> _db;
}

class IsarService extends _Service with _DiaryService, _DiaryImageService {
  IsarService() {
    _db = openDB();
  }

  Future<bool> importJsonWith(String path) async {
    try {
      final isar = await _db;
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

  Future<void> exportDiaryWith(String path) async {
    final isar = await _db;
    final data = isar.diarys.where().exportJson();
    final file = await File(path).create();
    await file.writeAsString(jsonEncode(data));
  }

  Future<void> cleanDb() async {
    final isar = await _db;
    await isar.writeAsync((isar) => isar.clear);
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationSupportDirectory();

    final isar = Isar.open(
      schemas: [
        DiarySchema,
        DiaryImageSchema,
      ],
      name: App.database,
      directory: dir.path,
      compactOnLaunch: const CompactCondition(
        minBytes: 1024,
        minFileSize: 1024,
      ),
    );

    return isar;
  }
}

mixin _DiaryService on _Service {
  Future<void> saveDiary(Diary newDiary) async {
    final isar = await _db;
    return isar.writeAsync((isar) => isar.diarys.put(newDiary));
  }

  Future<List<Diary>> getDiaryByDate(DateTime dateTime) async {
    final isar = await _db;
    return isar.diarys
        .where()
        .createDateTimeBetween(
          DateTime(dateTime.year, dateTime.month, dateTime.day),
          DateTime(dateTime.year, dateTime.month, dateTime.day).nextDay,
        )
        .findAll();
  }

  Stream<List<Diary>> listenToDiariesEditing() async* {
    final isar = await _db;
    yield* isar.diarys
        .where()
        .editingEqualTo(true)
        .watch(fireImmediately: true);
  }

  Future<List<Diary>> getAllDiaries() async {
    final isar = await _db;
    return isar.diarys.where().findAll();
  }

  Stream<List<Diary>> listenToAllDiaries() async* {
    final isar = await _db;
    yield* isar.diarys
        .where()
        .editingEqualTo(false)
        .sortByCreateDateTimeDesc()
        .watch(fireImmediately: true);
  }

  Future<void> deleteDiaryById(int id) async {
    final isar = await _db;
    await isar.writeAsync((isar) => isar.diarys.delete(id));
  }
}

mixin _DiaryImageService on _Service {
  Future<void> saveDiaryImage(DiaryImage newDiaryImage) async {
    final isar = await _db;
    await isar.writeAsync((isar) => isar.diaryImages.put(newDiaryImage));
  }

  Future<void> deleteDiaryImageById(int id) async {
    final isar = await _db;
    await isar.writeAsync((isar) => isar.diaryImages.delete(id));
  }

  Future<DiaryImage?> getDiaryImageById(int id) async {
    final isar = await _db;
    return isar.readAsync((isar) => isar.diaryImages.get(id));
  }

  Stream<List<DiaryImage>> listenToAllDiaryImages() async* {
    final isar = await _db;
    yield* isar.diaryImages
        .where()
        .sortByCreateDateTimeDesc()
        .watch(fireImmediately: true);
  }
}
