import 'package:mercurius/index.dart';

part 'github_latest_release.g.dart';

@JsonSerializable(explicitToJson: true)
class GithubLatestRelease {
  GithubLatestRelease();

  bool? enable;
  num? maxAge;
  num? maxCount;

  factory GithubLatestRelease.fromJson(Map<String, dynamic> json) =>
      _$GithubLatestReleaseFromJson(json);
  Map<String, dynamic> toJson() => _$GithubLatestReleaseToJson(this);
}
