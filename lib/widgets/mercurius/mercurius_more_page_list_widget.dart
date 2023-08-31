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

    final MercuriusL10N l10n = MercuriusL10N.of(context);

    final List<List<dynamic>> data = [
      [
        Icons.analytics,
        l10n.statistics,
        const StatisticPage(),
      ],
      [
        Icons.image_rounded,
        l10n.imageGallery,
        const GalleryPage(),
      ],
      [
        Icons.import_export_rounded,
        l10n.importAndExport,
        const IOPage(),
      ],
      [
        Icons.settings_rounded,
        l10n.settings,
        const SettingPage(),
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
              titleText: l10n.aboutApp,
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
