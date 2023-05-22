import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_version.g.dart';

@riverpod
Future<String> currentVersion(CurrentVersionRef ref) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return 'v${packageInfo.version}+${packageInfo.buildNumber}';
}
