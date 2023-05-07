import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'github_latest_release.g.dart';

@riverpod
Future<GithubLatestRelease> githubLatestRelease(Ref ref) async {
  MercuriusKit.printLog('githubLatestRelease 初始化中');

  const String url =
      'https://api.github.com/repos/Cierra-Runis/mercurius_warehouse/releases/latest';

  final profile = await ref.read(mercuriusProfileProvider.future);

  GithubLatestRelease githubLatestRelease = GithubLatestRelease()
    ..tag_name = profile.currentVersion;

  Response response;
  try {
    response = await Dio().get(url);
  } catch (e) {
    MercuriusKit.printLog('GithubLatestRelease 连接失败');
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode(
        '{"tag_name": "${profile.currentVersion}"}',
      ),
    );
    return githubLatestRelease;
  }

  MercuriusKit.printLog('GithubLatestRelease 连接成功');

  if (response.statusCode == 200) {
    MercuriusKit.printLog('GithubLatestRelease 请求成功');
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode('$response'),
    );
  } else {
    MercuriusKit.printLog('GithubLatestRelease 请求失败');
    githubLatestRelease = GithubLatestRelease.fromJson(
      jsonDecode(
        '{"tag_name": "${profile.currentVersion}"}',
      ),
    );
  }

  return githubLatestRelease;
}
