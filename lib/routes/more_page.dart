// ignore_for_file: non_constant_identifier_na
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
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UserModel()),
            ],
            child: Consumer<UserModel>(
              builder: (context, value, child) {
                return ListTile(
                  leading: const Icon(Icons.supervised_user_circle),
                  title: Text(Global.profile.user?.username ?? '未登录'),
                  onTap: () {
                    Global.profile.user = User()
                      ..mercuriusId = 0
                      ..username = '114'
                      ..email = 'byrdsaron@gmail.com';
                  },
                );
              },
            ),
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
    );
  }

  Future<void> _aboutDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AboutWidget();
      },
    );
  }
}
