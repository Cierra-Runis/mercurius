import 'package:mercurius/index.dart';

class PathModel extends ChangeNotifier {
  late Future<Directory?> directory;

  late String path;

  void init() async {
    DevTools.printLog('[045] pathModel 初始化中');

    // 可见于 Android/pers.cierra_runis.mercurius/files
    directory = getExternalStorageDirectory();

    directory.then((value) {
      DevTools.printLog('[046] 获取 path 为 $value');
      path = value.toString();
    });
  }
}
