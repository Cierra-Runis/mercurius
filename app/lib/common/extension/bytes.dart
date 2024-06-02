part of 'extension.dart';

abstract class Bytes {
  static String format({
    int? bytes,
    int decimals = 2,
  }) {
    if (bytes == null || bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

extension FileSystemEntityExt on FileSystemEntity {
  int getBytesSync() {
    if (!existsSync()) return 0;
    return switch (this) {
      final File file => file.lengthSync(),
      final Directory directory => directory.getBytesSync(),
      _ => 0,
    };
  }

  Future<int> getBytes() async {
    if (!existsSync()) return 0;
    return switch (this) {
      final File file => file.lengthSync(),
      final Directory directory => await directory.getBytes(),
      _ => 0,
    };
  }

  Stream<int> watchBytes({
    int events = FileSystemEvent.all,
    bool recursive = false,
  }) {
    return Stream.periodic(Durations.extralong4, (_) {})
        .asyncMap((event) => getBytes());
  }
}

extension DirectoryExt on Directory {
  int getBytesSync() {
    var sum = 0;
    if (!existsSync()) return 0;
    for (final file in listSync()) {
      sum += file.getBytesSync();
    }
    return sum;
  }

  Future<int> getBytes() async {
    var sum = 0;
    if (!existsSync()) return 0;
    for (final file in listSync()) {
      sum += await file.getBytes();
    }
    return sum;
  }
}

AsyncSnapshot<int> useBytes<T>(FileSystemEntity entity) =>
    useStream(entity.watchBytes(), initialData: entity.getBytesSync());
