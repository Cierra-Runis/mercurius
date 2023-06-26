import 'package:mercurius/index.dart';

class DatabaseMigrator {
  static const databaseVersion = 2;

  static Future<void> migration(Isar isar) async {
    await migrateV1ToV2(isar);
  }

  static Future<void> migrateV1ToV2(Isar isar) async {
    final diaries = await isar.diarys.where().findAll();
    await isar.writeTxn(() async => await isar.diarys.putAll(diaries));
  }
}
