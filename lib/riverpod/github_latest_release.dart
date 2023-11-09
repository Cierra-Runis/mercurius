// ignore_for_file: non_constant_identifier_names

import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'github_latest_release.g.dart';

@riverpod
Future<GithubLatestRelease> githubLatestRelease(
  GithubLatestReleaseRef ref,
) async {
  const url =
      'https://api.github.com/repos/Cierra-Runis/mercurius/releases/latest';

  final currentVersion = await ref.watch(currentVersionProvider.future);

  var githubLatestRelease = GithubLatestRelease()..tag_name = currentVersion;

  Response response;
  try {
    response = await Dio().get(url);
  } catch (e) {
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode(
        '{"tag_name": "$currentVersion"}',
      ),
    );
    return githubLatestRelease;
  }

  if (response.statusCode == 200) {
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode('$response'),
    );
  } else {
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
