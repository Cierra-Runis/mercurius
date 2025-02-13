import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fonts_loader.g.dart';

@riverpod
Future<void> fontsLoader(Ref ref) async {
  /// Check settings first
  final fontFamily = ref.watch(
    settingsProvider.select((value) => value.fontFamily),
  );
  final fontFilename = ref.watch(
    settingsProvider.select((value) => value.fontFilename),
  );

  /// If user didn't configure, return null
  if (fontFamily == null) return;
  if (fontFilename == null) return;

  final pathsFont = ref.watch(pathsProvider.select((value) => value.font));
  final fontLoader = FontLoader(fontFamily);
  final fontFile = File(p.join(pathsFont.path, fontFamily, fontFilename));

  /// Get the fonts manifest from remote
  final fontsManifest = ref.watch(fontsManifestProvider).value;
  final remoteFont = fontsManifest?.firstWhereOr(
    (e) => e.fontFamily == fontFamily,
  );

  if (!fontFile.existsSync()) {
    if (remoteFont == null || !remoteFont.files.contains(fontFilename)) return;

    App.showSnackBar(Text('Start Downloading $fontFilename'));
    final res = await App.dio.download(
      '${App.fontsFolderUrl}/$fontFamily/$fontFilename',
      fontFile.path,
    );

    if (res.statusCode == 200) {
      App.showSnackBar(Text('Downloaded $fontFilename Successfully'));
    } else {
      App.showSnackBar(
        Text('Download $fontFilename Failed (${res.statusCode})'),
      );
    }
  }

  final bytes = fontFile.readAsBytes();
  final byteData = bytes.then((value) => ByteData.view(value.buffer));
  fontLoader.addFont(byteData);
  fontLoader.load();
  App.showSnackBar(Text('Loaded $fontFilename'));
}

abstract final class FontsLoader {
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
