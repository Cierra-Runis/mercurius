import 'package:mercurius/index.dart';

class MercuriusOriginalMorePageListWidget extends ConsumerWidget {
  const MercuriusOriginalMorePageListWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

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
        MercuriusModifiedListSection(
          children: [
            ...list,
            MercuriusModifiedListItem(
              iconData: Icons.info_outline,
              showAccessoryViewBadge: githubLatestRelease.when(
                loading: () => false,
                error: (error, stackTrace) => false,
                data: (github) => mercuriusProfile.when(
                  loading: () => false,
                  error: (error, stackTrace) => false,
                  data: (profile) => profile.currentVersion != github.tag_name,
                ),
              ),
              titleText: '关于',
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) => const DialogAboutWidget(),
              ),
            )
          ],
        ),
      ],
    );
  }
}
