import 'package:mercurius/index.dart';

class MercuriusMorePage extends StatelessWidget {
  const MercuriusMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<MercuriusProfileNotifier>(
          builder: (context, value, child) => IconButton(
            icon: const Icon(UniconsLine.user_circle),
            onPressed: () {
              MercuriusKit.vibration();
              if (mercuriusProfileNotifier.profile.user == null) {
                showDialog<void>(
                  context: context,
                  builder: (context) => const DialogLoginWidget(),
                );
              } else {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const MercuriusProfilePage(),
                  ),
                );
              }
            },
          ),
        ),
        title: const MercuriusOriginalTitleWidget(),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MercuriusModifiedList(
              children: [
                MercuriusModifiedListSection(
                  children: [
                    MercuriusModifiedListItem(
                      iconData: Icons.analytics,
                      titleText: '统计数据',
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const DiaryStatisticPage(),
                        ),
                      ),
                    ),
                    MercuriusModifiedListItem(
                      iconData: Icons.image_rounded,
                      titleText: '图片库',
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const MercuriusGalleryPage(),
                        ),
                      ),
                    ),
                    MercuriusModifiedListItem(
                      iconData: Icons.import_export_rounded,
                      titleText: '导入导出',
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const MercuriusIOPage(),
                        ),
                      ),
                    ),
                    MercuriusModifiedListItem(
                      iconData: Icons.settings,
                      titleText: '设定',
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
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
                      ) =>
                          MercuriusModifiedListItem(
                        iconData: Icons.info_outline,
                        showAccessoryViewBadge: mercuriusProfileNotifier
                                .profile.currentVersion !=
                            mercuriusWebNotifier.githubLatestRelease.tag_name,
                        titleText: '关于',
                        onTap: () => showDialog<void>(
                          context: context,
                          builder: (context) {
                            return const DialogAboutWidget();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: MercuriusOriginalHiToKoToWidget(),
          ),
        ],
      ),
    );
  }
}
