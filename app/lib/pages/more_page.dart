import 'package:mercurius/index.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.morePage),
      ),
      body: const BasedListView(
        children: [
          _MoreSection(),
          _AboutSection(),
        ],
      ),
      bottomNavigationBar: const HiToKoToWidget(),
    );
  }
}

class _MoreSection extends StatelessWidget {
  const _MoreSection();

  @override
  Widget build(BuildContext context) {
    return const BasedListSection(
      children: [
        _StatisticTile(),
        _ImageGalleryTile(),
        _IOTile(),
        _SettingsTile(),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.aboutApp,
      titleTextStyle: const TextStyle(),
      children: const [
        _ReleaseTile(),
        _ContactTile(),
        _ImportDeclarationTile(),
        _PrivacyStatementTile(),
      ],
    );
  }
}

class _StatisticTile extends StatelessWidget {
  const _StatisticTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.analytics_rounded,
      titleText: l10n.statistics,
      onTap: () => context.push(const StatisticPage()),
    );
  }
}

class _ImageGalleryTile extends StatelessWidget {
  const _ImageGalleryTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.image_rounded,
      titleText: l10n.imageGallery,
      onTap: () => context.push(const GalleryPage()),
    );
  }
}

class _IOTile extends StatelessWidget {
  const _IOTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.import_export_rounded,
      titleText: l10n.importAndExport,
      onTap: () => context.push(const IOPage()),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.settings_rounded,
      titleText: l10n.settings,
      onTap: () => context.push(const SettingsPage()),
    );
  }
}

class _ReleaseTile extends ConsumerWidget {
  const _ReleaseTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final tagName = ref.watch(packageInfoProvider).tagName;

    final hasUpdate = githubLatestRelease.when(
      loading: () => false,
      error: (error, stackTrace) => false,
      data: (github) => tagName != github.tagName,
    );

    return BasedListTile(
      leading: const AppIcon(size: 24),
      titleText: App.name,
      subtitleText: tagName,
      detailText:
          hasUpdate ? l10n.clickHereToUpdate : l10n.alreadyTheLatestVersion,
      showTrailingBadge: hasUpdate,
      onTap: () => context.push(const ReleasePage()),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
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
    );
  }
}

class _ImportDeclarationTile extends StatelessWidget {
  const _ImportDeclarationTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
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
    );
  }
}

class _PrivacyStatementTile extends StatelessWidget {
  const _PrivacyStatementTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
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
    );
  }
}
