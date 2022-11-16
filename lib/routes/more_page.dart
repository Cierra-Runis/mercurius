import 'package:mercurius/index.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Consumer<ProfileModel>(
              builder: (context, profileModel, child) {
                return ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: Text(profileModel.profile.user == null
                      ? '未登录'
                      : profileModel.profile.user?.username ??
                          '不写 username 的屑'),
                  onTap: () {
                    if (profileModel.profile.user == null) {
                      _loginDialog(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            const Divider(
              height: 5,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('设定'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
            ),
            const Divider(
              height: 5,
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('关于'),
              onTap: () => _aboutDialog(context),
            ),
            const Divider(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              child: const HiToKoToWidget(),
            )
          ],
        ),
      ),
    ));
  }

  Future<void> _aboutDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AboutDialogWidget();
      },
    );
  }

  Future<void> _loginDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LoginDialogWidget();
      },
    );
  }
}
