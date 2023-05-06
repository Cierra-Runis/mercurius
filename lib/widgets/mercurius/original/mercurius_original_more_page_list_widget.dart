import 'package:mercurius/index.dart';

class MercuriusOriginalMorePageListWidget extends StatelessWidget {
  const MercuriusOriginalMorePageListWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> data = [
      [Icons.analytics, '统计数据', const DiaryStatisticPage()],
      [Icons.image_rounded, '图片库', const MercuriusGalleryPage()],
      [Icons.import_export_rounded, '导入导出', const MercuriusIOPage()],
      [Icons.settings_rounded, '设定', const MercuriusSettingPage()],
    ];

    List<Widget> list = [];
    for (List<dynamic> element in data) {
      list.add(
        MercuriusModifiedListItem(
          iconData: element[0],
          titleText: element[1],
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => element[2]),
          ),
        ),
      );
    }

    return MercuriusModifiedList(
      children: [
        MercuriusModifiedListSection(children: [
          ...list,
          Consumer2<MercuriusProfileNotifier, MercuriusWebNotifier>(
            builder: (
              context,
              mercuriusProfileNotifier,
              mercuriusWebNotifier,
              child,
            ) {
              return MercuriusModifiedListItem(
                iconData: Icons.info_outline,
                showAccessoryViewBadge:
                    mercuriusProfileNotifier.profile.currentVersion !=
                        mercuriusWebNotifier.githubLatestRelease.tag_name,
                titleText: '关于',
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (context) => const DialogAboutWidget(),
                ),
              );
            },
          ),
        ])
      ],
    );
  }
}
