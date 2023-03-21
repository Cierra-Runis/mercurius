import 'package:mercurius/index.dart';

class MercuriusProfilePage extends StatelessWidget {
  const MercuriusProfilePage({super.key});

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
            Consumer<MercuriusProfileNotifier>(
              builder: (context, mercuriusProfileNotifier, child) {
                return ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('退出帐号'),
                    ],
                  ),
                  onTap: () {
                    mercuriusProfileNotifier.changeProfile(
                      mercuriusProfileNotifier.profile..user = null,
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
