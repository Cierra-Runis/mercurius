import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'paths.g.dart';

@Riverpod(keepAlive: true)
Paths paths(Ref ref) => throw Exception('$pathsProvider not initialized');

class Paths {
  final Directory temp;
  final Directory appSupport;
  final Directory appCache;
  final Directory documents;

  const Paths._({
    required this.temp,
    required this.appSupport,
    required this.appCache,
    required this.documents,
  });

  Directory get font => Directory(p.join(appSupport.path, 'font'));

  Directory get image => Directory(p.join(appSupport.path, 'image'));

  static Future<Paths> init() async {
    final paths = Paths._(
      temp: await getTemporaryDirectory(),
      appSupport: await getApplicationSupportDirectory(),
      appCache: await getApplicationCacheDirectory(),
      documents: await getApplicationDocumentsDirectory(),
    );

    await paths.image.create();
    await paths.font.create();

    return paths;
  }
}
