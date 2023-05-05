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
        child: MercuriusModifiedList(
          padding: const EdgeInsets.all(8),
          children: [
            Consumer<MercuriusProfileNotifier>(
              builder: (context, mercuriusProfileNotifier, child) =>
                  MercuriusModifiedListSection(
                children: [
                  MercuriusModifiedListItem(
                    iconData: Icons.logout_rounded,
                    titleText: '退出帐号',
                    onTap: () {
                      mercuriusProfileNotifier.changeProfile(
                        mercuriusProfileNotifier.profile..user = null,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
