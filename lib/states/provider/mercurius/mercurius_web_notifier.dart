import 'package:mercurius/index.dart';

const String _url =
    'https://api.github.com/repos/Cierra-Runis/mercurius_warehouse/releases/latest';

class MercuriusWebNotifier extends ChangeNotifier {
  GithubLatestRelease githubLatestRelease = GithubLatestRelease()
    ..tag_name = mercuriusProfileNotifier.profile.currentVersion;

  void init() {
    MercuriusKit.printLog('GithubLatestRelease 初始化中');
    _fetchGithubLatestRelease();
  }

  void _fetchGithubLatestRelease() async {
    Response response;
    try {
      response = await Dio().get(_url);
    } catch (e) {
      MercuriusKit.printLog('GithubLatestRelease 连接失败');
      githubLatestRelease = GithubLatestRelease.fromJson(
        jsonDecode(
          '{"tag_name": "${mercuriusProfileNotifier.profile.currentVersion}"}',
        ),
      );
      notifyListeners();
      super.notifyListeners();
      return;
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
          '{"tag_name": "${mercuriusProfileNotifier.profile.currentVersion}"}',
        ),
      );
    }
    notifyListeners();
    super.notifyListeners();
  }

  void refetchGithubLatestRelease() {
    _fetchGithubLatestRelease();
    notifyListeners();
    super.notifyListeners();
  }
}
