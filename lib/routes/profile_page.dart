import 'package:mercurius/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人界面'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Consumer<ProfileModel>(
              builder: (context, profileModel, child) {
                return ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('退出帐号'),
                    ],
                  ),
                  onTap: () {
                    profileModel.changeProfile(
                      profileModel.profile..user = null,
                    );
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            const Divider(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
