import 'package:mercurius/index.dart';

class MorePageList extends ConsumerWidget {
  const MorePageList({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

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
        const SettingPage(),
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

class AboutSection extends ConsumerWidget {
  const AboutSection({
    super.key,
  });

  bool hasNewVersion(
    AsyncValue<GithubLatestRelease> githubLatestRelease,
    AsyncValue<String> currentVersion,
  ) =>
      githubLatestRelease.when(
        loading: () => false,
        error: (error, stackTrace) => false,
        data: (github) => currentVersion.when(
          loading: () => false,
          error: (error, stackTrace) => false,
          data: (currentVersion) => currentVersion != github.tag_name,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final currentVersion = ref.watch(currentVersionProvider);

    return BasedListSection(
      titleText: l10n.aboutApp,
      titleTextStyle: const TextStyle(),
      children: [
        BasedListTile(
          leading: const AppIcon(size: 24),
          titleText: App.name,
          subtitleText: currentVersion.when(
            loading: () => l10n.unknownVersion,
            error: (error, stackTrace) => l10n.failedToGetVersion,
            data: (data) => data,
          ),
          detailText: hasNewVersion(githubLatestRelease, currentVersion)
              ? l10n.clickHereToUpdate
              : l10n.alreadyTheLatestVersion,
          showTrailingBadge: hasNewVersion(githubLatestRelease, currentVersion),
          onTap: () => context.push(const ReleasePage()),
        ),
        // DialogAboutTitleWidget(),
        BasedListTile(
          leadingIcon: Icons.link,
          titleText: l10n.contactUs,
          subtitleText: App.contactUrl,
          onTap: () {
            try {
              launchUrlString(
                App.contactUrl,
                mode: LaunchMode.externalApplication,
              );
            } catch (e) {
              App.printLog(
                'launch ${App.contactUrl} failed: $e',
              );
            }
          },
        ),
        BasedListTile(
          leadingIcon: Icons.import_contacts_rounded,
          titleText: l10n.importDeclaration,
          subtitleText: l10n.importDeclarationDescription,
          onTap: () => showDialog(
            context: context,
            builder: (context) => JsonToDialog(
              title: l10n.importDeclaration,
              updateTime: l10n.importDeclarationContentUpdateTime,
              content: l10n.importDeclarationContent,
            ),
          ),
        ),
        BasedListTile(
          leadingIcon: Icons.privacy_tip_rounded,
          titleText: l10n.privacyStatement,
          subtitleText: '${App.name} ${l10n.privacyStatement}',
          onTap: () => showDialog(
            context: context,
            builder: (context) => JsonToDialog(
              title: l10n.privacyStatement,
              updateTime: l10n.privacyStatementContentUpdateTime,
              content: l10n.privacyStatementContent,
            ),
          ),
        ),
      ],
    );
  }
}
