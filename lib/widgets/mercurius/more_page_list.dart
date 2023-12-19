import 'package:mercurius/index.dart';

class MorePageList extends ConsumerWidget {
  const MorePageList({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    final data = <List<dynamic>>[
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
        const SettingsPage(),
      ],
    ];

    final list = <Widget>[];
    for (final element in data) {
      list.add(
        BasedListTile(
          leadingIcon: element[0],
          titleText: element[1],
          onTap: () => context.push(element[2]),
        ),
      );
    }

    return BasedListView(
      children: [
        BasedListSection(
          titleText: l10n.morePage,
          children: list,
        ),
        const AboutSection(),
      ],
    );
  }
}
