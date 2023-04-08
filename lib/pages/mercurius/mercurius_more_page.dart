import 'package:mercurius/index.dart';

class MercuriusMorePage extends StatelessWidget {
  const MercuriusMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<MercuriusProfileNotifier>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: () {
                MercuriusKit.vibration();
                if (mercuriusProfileNotifier.profile.user == null) {
                  _showDialogLoginWidget(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MercuriusProfilePage(),
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
            child: MercuriusList(
              children: [
                MercuriusListSection(
                  children: [
                    MercuriusListItem(
                      iconData: Icons.analytics,
                      titleText: '统计数据',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DiaryStatisticPage(),
                        ),
                      ),
                    ),
                    MercuriusListItem(
                      iconData: Icons.settings,
                      titleText: '设定',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MercuriusSettingPage(),
                        ),
                      ),
                    ),
                    Consumer2<MercuriusProfileNotifier, MercuriusWebNotifier>(
                      builder: (
                        context,
                        mercuriusProfileNotifier,
                        mercuriusWebNotifier,
                        child,
                      ) {
                        return MercuriusListItem(
                          iconData: Icons.info_outline,
                          showAccessoryViewBadge: mercuriusProfileNotifier
                                  .profile.currentVersion !=
                              mercuriusWebNotifier.githubLatestRelease.tag_name,
                          titleText: '关于',
                          onTap: () => _showDialogAboutWidget(context),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: HiToKoToWidget(),
          ),
        ],
      ),
    );
  }

  Future<void> _showDialogAboutWidget(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const DialogAboutWidget();
      },
    );
  }

  Future<void> _showDialogLoginWidget(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const DialogLoginWidget();
      },
    );
  }
}
