import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'github_latest_release.g.dart';
part 'github_latest_release.freezed.dart';

@riverpod
Future<GithubLatestRelease> githubLatestRelease(
  GithubLatestReleaseRef ref,
) async {
  const url =
      'https://api.github.com/repos/Cierra-Runis/mercurius/releases/latest';

  final tagName = ref.watch(packageInfoProvider).tagName;

  final githubLatestRelease = GithubLatestRelease(tagName: tagName);

  Response response;
  try {
    response = await Dio().get(url);
  } catch (e) {
    return githubLatestRelease;
  }

  if (response.statusCode == 200) {
    return GithubLatestRelease.fromJson(
      jsonDecode('$response'),
    );
  }

  return githubLatestRelease;
}

@freezed
class GithubLatestRelease with _$GithubLatestRelease {
  const factory GithubLatestRelease({
    @JsonKey(name: 'tag_name') required String tagName,
    @JsonKey(name: 'assets') List<AssetsItem>? assets,
    @JsonKey(name: 'body') String? body,
  }) = _GithubLatestRelease;

  const GithubLatestRelease._();

  factory GithubLatestRelease.fromJson(Json json) =>
      _$GithubLatestReleaseFromJson(json);
}

@freezed
class AssetsItem with _$AssetsItem {
  const factory AssetsItem({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'content_type') required String contentType,
    @JsonKey(name: 'browser_download_url') required String browserDownloadUrl,
  }) = _AssetsItem;

  const AssetsItem._();

  factory AssetsItem.fromJson(Json json) => _$AssetsItemFromJson(json);
}
