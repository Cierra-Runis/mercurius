import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_latest_release.freezed.dart';
part 'github_latest_release.g.dart';

@riverpod
Future<GitHubLatestRelease> gitHubLatestRelease(
  GitHubLatestReleaseRef ref,
) async {
  ref.refreshFor(const Duration(minutes: 5));
  const url =
      'https://api.github.com/repos/Cierra-Runis/mercurius/releases/latest';

  final tagName = ref.watch(packageInfoProvider).tagName;

  final gitHubLatestRelease = GitHubLatestRelease(tagName: tagName);

  Response response;
  try {
    response = await Dio().get(url);
  } catch (e) {
    return gitHubLatestRelease;
  }

  if (response.statusCode == 200) {
    return GitHubLatestRelease.fromJson(
      jsonDecode('$response'),
    );
  }

  return gitHubLatestRelease;
}

@freezed
class GitHubLatestRelease with _$GitHubLatestRelease {
  const factory GitHubLatestRelease({
    @JsonKey(name: 'tag_name') required String tagName,
    @JsonKey(name: 'assets') List<AssetsItem>? assets,
    @JsonKey(name: 'body') String? body,
  }) = _GitHubLatestRelease;

  const GitHubLatestRelease._();

  factory GitHubLatestRelease.fromJson(Json json) =>
      _$GitHubLatestReleaseFromJson(json);
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
