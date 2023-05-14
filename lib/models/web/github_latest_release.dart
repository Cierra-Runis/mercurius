// ignore_for_file: non_constant_identifier_names

import 'package:mercurius/index.dart';

part 'github_latest_release.g.dart';

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
