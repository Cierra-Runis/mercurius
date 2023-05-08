import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'github_latest_release.g.dart';

@riverpod
Future<GithubLatestRelease> githubLatestRelease(
    GithubLatestReleaseRef ref) async {
  MercuriusKit.printLog('GithubLatestRelease 初始化中');

  const String url =
      'https://api.github.com/repos/Cierra-Runis/mercurius_warehouse/releases/latest';

  final profile = await ref.watch(mercuriusProfileProvider.future);

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

  /// TIPS: 启用这里的 10s 延迟会有很多 “有趣的事情” 发生
  // await Future.delayed(const Duration(seconds: 10));

  return githubLatestRelease;
}
