import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fonts_manifest.g.dart';

@riverpod
Future<List<Font>> fontsManifest(Ref ref) async {
  final response = await App.dio.get(App.fontsManifestUrl);
  final jsonList = jsonDecode(response.data) as List;
  return jsonList.map((e) => Font.fromJson(e as Json)).toList();
}
