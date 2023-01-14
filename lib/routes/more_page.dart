import 'package:mercurius/index.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ProfileModel>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: () {
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
        title: const MercuriusTitleWidget(),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            children: [
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('设定'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                ),
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
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: HiToKoToWidget(),
          )
        ],
      ),
    );
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
