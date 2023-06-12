import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mercurius_path.g.dart';

@riverpod
Future<String> mercuriusPath(MercuriusPathRef ref) async {
  Mercurius.printLog('MercuriusPath 初始化中');

  /// TIPS: 即 /storage/emulated/0/Android/data/pers.cierra_runis.mercurius/files
  Directory? directory = await getExternalStorageDirectory();
  String path = directory!.path;

  Directory imageDirectory = Directory('$path/image/');
  if (!imageDirectory.existsSync()) imageDirectory.create();

  Mercurius.printLog('MercuriusPath 初始化为 $path');

  return path;
}