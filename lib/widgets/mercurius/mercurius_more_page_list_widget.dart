import 'package:mercurius/index.dart';

class MercuriusMorePageListWidget extends ConsumerWidget {
  const MercuriusMorePageListWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final currentVersion = ref.watch(currentVersionProvider);

    List<List<dynamic>> data = [
      [Icons.analytics, '统计数据', const DiaryStatisticPage()],
      [Icons.image_rounded, '图片库', const MercuriusGalleryPage()],
      [Icons.import_export_rounded, '导入导出', const MercuriusIOPage()],
      [Icons.settings_rounded, '设定', const MercuriusSettingPage()],
    ];

    List<Widget> list = [];
    for (List<dynamic> element in data) {
      list.add(
        MercuriusListItemWidget(
          iconData: element[0],
          titleText: element[1],
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => element[2]),
          ),
        ),
      );
    }

    return MercuriusListWidget(
      children: [
        MercuriusListSectionWidget(
          children: [
            ...list,
            MercuriusListItemWidget(
              iconData: Icons.info_outline,
              showAccessoryViewBadge: githubLatestRelease.when(
                loading: () => false,
                error: (error, stackTrace) => false,
                data: (github) => currentVersion.when(
                  loading: () => false,
                  error: (error, stackTrace) => false,
                  data: (currentVersion) => currentVersion != github.tag_name,
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
