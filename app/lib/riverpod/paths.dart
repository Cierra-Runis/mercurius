import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'paths.g.dart';

@riverpod
Paths paths(PathsRef ref) => throw Exception('pathsProvider not initialized');

class Paths {
  final Directory temp;
  final Directory appSupport;
  final Directory appCache;
  final Directory documents;

  Directory get imageDirectory => Directory(
        join(appSupport.path, 'image'),
      )..create();

  const Paths._({
    required this.temp,
    required this.appSupport,
    required this.appCache,
    required this.documents,
  });

  static Future<Paths> init() async {
    final paths = Paths._(
      temp: await getTemporaryDirectory(),
      appSupport: await getApplicationSupportDirectory(),
      appCache: await getApplicationCacheDirectory(),
      documents: await getApplicationDocumentsDirectory(),
    );
    return paths;
  }
}
