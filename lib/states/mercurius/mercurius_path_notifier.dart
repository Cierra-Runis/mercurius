import 'package:mercurius/index.dart';

class MercuriusPathNotifier extends ChangeNotifier {
  late Future<Directory?> directory;

  late String path;

  void init() async {
    MercuriusKit.printLog('mercuriusPathNotifier 初始化中');

    /// TIPS: 即 /storage/emulated/0/Android/data/pers.cierra_runis.mercurius/files
    Directory? directory = await getExternalStorageDirectory();
    path = directory!.path;
  }
}
