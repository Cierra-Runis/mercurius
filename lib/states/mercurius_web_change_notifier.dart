import 'package:mercurius/index.dart';

const String _url =
    'https://api.github.com/repos/Cierra-Runis/mercurius_warehouse/releases/latest';

class MercuriusWebModel extends ChangeNotifier {
  GithubLatestRelease githubLatestRelease = GithubLatestRelease();

  void _fetchGithubLatestRelease() async {
    Response response;
    try {
      response = await Dio().get(_url);
    } catch (e) {
      DevTools.printLog('GithubLatestRelease 连接失败');
      githubLatestRelease = GithubLatestRelease.fromJson(
        jsonDecode(
          '{"tag_name": "${profileModel.profile.currentVersion}"}',
        ),
      );
      notifyListeners();
      super.notifyListeners();
      return;
    }

    DevTools.printLog('GithubLatestRelease 连接成功');

    if (response.statusCode == 200) {
      DevTools.printLog('GithubLatestRelease 请求成功');
      githubLatestRelease = GithubLatestRelease.fromJson(
        jsonDecode(response.toString()),
      );
    } else {
      DevTools.printLog('GithubLatestRelease 请求失败');
      githubLatestRelease = GithubLatestRelease.fromJson(
        jsonDecode(
          '{"tag_name": "${profileModel.profile.currentVersion}"}',
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

  void init() {
    DevTools.printLog('GithubLatestRelease 初始化中');
    _fetchGithubLatestRelease();
  }
}
