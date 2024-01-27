import 'package:mercurius/index.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({
    super.key,
  });

  bool hasNewVersion(
    AsyncValue<GithubLatestRelease> githubLatestRelease,
    String tagName,
  ) =>
      githubLatestRelease.when(
        loading: () => false,
        error: (error, stackTrace) => false,
        data: (github) => tagName != github.tagName,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final tagName = ref.watch(packageInfoProvider).tagName;

    return BasedListSection(
      titleText: l10n.aboutApp,
      titleTextStyle: const TextStyle(),
      children: [
        BasedListTile(
          leading: const AppIcon(size: 24),
          titleText: App.name,
          subtitleText: tagName,
          detailText: hasNewVersion(githubLatestRelease, tagName)
              ? l10n.clickHereToUpdate
              : l10n.alreadyTheLatestVersion,
          showTrailingBadge: hasNewVersion(githubLatestRelease, tagName),
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
          onTap: () => context.pushDialog(
            JsonToDialog(
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
          onTap: () => context.pushDialog(
            JsonToDialog(
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
