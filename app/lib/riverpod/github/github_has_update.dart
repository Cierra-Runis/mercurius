import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_has_update.g.dart';

@riverpod
Future<bool> githubHasUpdate(Ref ref) async {
  final localVersion = ref.watch(packageInfoProvider);
  final githubLatestRelease =
      await ref.watch(githubLatestReleaseProvider.future);
  return Version.parse(localVersion.tagName) <
      Version.parse(githubLatestRelease.tagName);
}
