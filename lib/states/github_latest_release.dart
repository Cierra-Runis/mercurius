// ignore_for_file: non_constant_identifier_names

import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'github_latest_release.g.dart';

@riverpod
Future<GithubLatestRelease> githubLatestRelease(
  GithubLatestReleaseRef ref,
) async {
  Mercurius.printLog('GithubLatestRelease 初始化中');

  const String url =
      'https://api.github.com/repos/Cierra-Runis/mercurius/releases/latest';

  String currentVersion = await ref.watch(currentVersionProvider.future);

  GithubLatestRelease githubLatestRelease = GithubLatestRelease()
    ..tag_name = currentVersion;

  Response response;
  try {
    response = await Dio().get(url);
  } catch (e) {
    Mercurius.printLog('GithubLatestRelease 连接失败');
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode(
        '{"tag_name": "$currentVersion"}',
      ),
    );
    return githubLatestRelease;
  }

  Mercurius.printLog('GithubLatestRelease 连接成功');

  if (response.statusCode == 200) {
    Mercurius.printLog('GithubLatestRelease 请求成功');
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode('$response'),
    );
  } else {
    Mercurius.printLog('GithubLatestRelease 请求失败');
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode(
        '{"tag_name": "$currentVersion"}',
      ),
    );
  }

  return githubLatestRelease;
}

@JsonSerializable()
class GithubLatestRelease {
  GithubLatestRelease();

  String? tag_name;
  String? name;
  bool? draft;
  bool? prerelease;
  List<GithubLatestReleaseAsset>? assets;
  String? body;

  factory GithubLatestRelease.fromJson(Map<String, dynamic> json) =>
      _$GithubLatestReleaseFromJson(json);
  Map<String, dynamic> toJson() => _$GithubLatestReleaseToJson(this);
}

@JsonSerializable()
class GithubLatestReleaseAsset {
  GithubLatestReleaseAsset();

  String? name;
  int? size;
  int? download_count;
  DateTime? created_at;
  DateTime? updated_at;
  String? browser_download_url;

  factory GithubLatestReleaseAsset.fromJson(Map<String, dynamic> json) =>
      _$GithubLatestReleaseAssetFromJson(json);
  Map<String, dynamic> toJson() => _$GithubLatestReleaseAssetToJson(this);
}
