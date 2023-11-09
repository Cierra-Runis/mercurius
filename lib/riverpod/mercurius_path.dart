import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'mercurius_path.g.dart';

@riverpod
Future<String> mercuriusPath(MercuriusPathRef ref) async {
  /// TIPS: 对 Android 而言为 /storage/emulated/0/Android/data/pers.cierra_runis.mercurius/files
  /// TIPS: 对 Windows 而言为 C:\Users\{user_name}\AppData\Roaming\pers.cierra_runis\Mercurius
  Directory? directory;

  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else if (Platform.isWindows) {
    directory = await getApplicationSupportDirectory();
  } else {
    throw Exception('Unsupported Platform');
  }

  final path = directory!.path;

  final imageDirectory = Directory('$path/image/');
  if (!imageDirectory.existsSync()) imageDirectory.create();

  return path;
}
