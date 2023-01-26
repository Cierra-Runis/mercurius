import 'package:mercurius/index.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ProfileModel>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: () {
                Vibration.vibrate(duration: 50, amplitude: 255);
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
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.analytics),
                  title: const Text(
                    '统计数据',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Saira',
                    ),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiaryStatisticPage(),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text(
                    '设定',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Saira',
                    ),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingPage(),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text(
                    '关于',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Saira',
                    ),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => _aboutDialog(context),
                ),
              ],
            ),
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
