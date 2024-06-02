import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fonts_loader.g.dart';

@riverpod
Future<void> fontsLoader(FontsLoaderRef ref) async {
  App.printLog('log');

  /// Check settings first
  /// If user didn't config it, do nothing
  final settings = ref.watch(settingsProvider);
  final fontFamily = settings.fontFamily;
  if (fontFamily == null) return;

  /// Else get the fonts manifest from remote
  /// If user's config doesn't exist in remote,
  /// then clear the settings
  final setSettings = ref.watch(settingsProvider.notifier);
  final fontsManifest = await ref.watch(fontsManifestProvider.future);
  final font = fontsManifest.firstWhereOr((e) => e.fontFamily == fontFamily);
  if (font == null) {
    setSettings.setFontFamily(null);
    return;
  }

  /// Now every time we get new font, enable the font
  final paths = ref.watch(pathsProvider);
  final fontLoader = FontLoader(fontFamily);

  for (final filename in font.files) {
    final fontFile = File(p.join(paths.font.path, filename));

    if (!fontFile.existsSync()) {
      await Dio().download('${App.fontsFolderUrl}/$filename', fontFile.path);
    }

    fontLoader.addFont(
      fontFile.readAsBytes().then((value) => ByteData.view(value.buffer)),
    );
  }

  return fontLoader.load();
}

abstract class FontsLoader {
  static void deleteFont(Font font, Directory fontDirectory) async {
    try {
      for (final filename in font.files) {
        final fontFile = File(p.join(fontDirectory.path, filename));
        fontFile.deleteSync(recursive: true);
        Directory(p.join(fontDirectory.path));
      }
    } catch (e, s) {
      App.printLog('Delete Error', error: e, stackTrace: s);
    }
  }
}
