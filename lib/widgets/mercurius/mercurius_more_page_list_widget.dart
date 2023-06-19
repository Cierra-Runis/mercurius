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

    final S localizations = S.of(context);

    final List<List<dynamic>> data = [
      [
        Icons.analytics,
        localizations.statistics,
        const DiaryStatisticPage(),
      ],
      [
        Icons.image_rounded,
        localizations.imageGallery,
        const MercuriusGalleryPage(),
      ],
      [
        Icons.import_export_rounded,
        localizations.importAndExport,
        const MercuriusIOPage(),
      ],
      [
        Icons.settings_rounded,
        localizations.settings,
        const MercuriusSettingPage(),
      ],
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
              titleText: localizations.aboutUs,
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
