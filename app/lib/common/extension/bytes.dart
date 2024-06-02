part of 'extension.dart';

abstract class Bytes {
  static String format({
    required int bytes,
    int decimals = 2,
  }) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

extension FileSystemEntityExt on FileSystemEntity {
  int getBytes() => switch (this) {
        final File file => file.lengthSync(),
        final Directory directory => directory.getBytes(),
        _ => 0,
      };
}

extension DirectoryExt on Directory {
  int getBytes() {
    var sum = 0;
    for (final file in listSync()) {
      sum += file.getBytes();
    }
    return sum;
  }
}
