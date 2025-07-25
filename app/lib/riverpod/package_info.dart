import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info.g.dart';

@Riverpod(keepAlive: true)
PackageInfo packageInfo(Ref ref) =>
    throw Exception('$packageInfoProvider not initialized');

extension PackageInfoExt on PackageInfo {
  String get tagName => '$version+$buildNumber';
}
