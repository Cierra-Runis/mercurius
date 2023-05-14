import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mercurius_path.g.dart';

@riverpod
Future<String> mercuriusPath(MercuriusPathRef ref) async {
  MercuriusKit.printLog('MercuriusPath 初始化中');

  /// TIPS: 即 /storage/emulated/0/Android/data/pers.cierra_runis.mercurius/files
  Directory? directory = await getExternalStorageDirectory();
  String path = directory!.path;

  Directory imageDirectory = Directory('$path/image/');
  if (!imageDirectory.existsSync()) imageDirectory.create();

  /// TIPS: 需要清除缓存，否则使用选择的和以前一样名称的文件
  await FilePicker.platform.clearTemporaryFiles();

  MercuriusKit.printLog('MercuriusPath 初始化为 $path');

  return path;
}
