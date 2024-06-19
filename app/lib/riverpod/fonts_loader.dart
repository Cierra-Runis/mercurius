import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fonts_loader.g.dart';

@riverpod
Future<void> fontsLoader(FontsLoaderRef ref) async {
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

  /// FIXME: Font loading order is Wrong
  for (final filename in font.files) {
    final fontFile = File(p.join(paths.font.path, font.fontFamily, filename));

    if (!fontFile.existsSync()) {
      final res = await App.dio.download(
        '${App.fontsFolderUrl}/$fontFamily/$filename',
        fontFile.path,
      );

      if (res.statusCode == 200) {
        App.showSnackBar(Text('Download $filename Done.'));
      }
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
      final fontFolder = Directory(p.join(fontDirectory.path, font.fontFamily));
      if (!fontFolder.existsSync()) return;
      fontFolder.deleteSync(recursive: true);
    } catch (e, s) {
      App.printLog('Delete Error', error: e, stackTrace: s);
    }
  }
}
