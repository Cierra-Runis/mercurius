import 'package:mercurius/index.dart';

class MercuriusProfilePage extends ConsumerWidget {
  const MercuriusProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('个人界面'),
      ),
      body: Center(
        child: MercuriusListWidget(
          padding: const EdgeInsets.all(8),
          children: [
            MercuriusListSectionWidget(
              children: [
                MercuriusListItemWidget(
                  iconData: Icons.logout_rounded,
                  titleText: '退出帐号',
                  onTap: mercuriusProfile.when(
                    loading: () => null,
                    error: (error, stackTrace) => null,
                    data: (profile) => () {
                      ref
                          .watch(mercuriusProfileProvider.notifier)
                          .changeProfile(profile..user = null);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
