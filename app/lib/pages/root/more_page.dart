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
        _ThirdPartyLicenseTile(),
        _PrivacyPolicyTile(),
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

    final githubHasUpdate = ref.watch(githubHasUpdateProvider);
    final tagName = ref.watch(packageInfoProvider).tagName;
    final hasUpdate = githubHasUpdate.value ?? false;

    return BasedListTile(
      leading: const AppIcon(size: 24),
      titleText: App.name,
      titleTextStyle: const TextStyle(
        fontFamily: App.fontSaira,
        fontSize: App.fontSize16,
      ),
      subtitleText: '$tagName ${App.builtAt}',
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
      subtitleText: App.githubUrl,
      onTap: () => App.launchUrl(App.githubUrl),
    );
  }
}

class _ThirdPartyLicenseTile extends StatelessWidget {
  const _ThirdPartyLicenseTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.import_contacts_rounded,
      titleText: l10n.thirdPartyLicense,
      subtitleText: l10n.thirdPartyLicenseDescription,
      onTap: () => App.launchUrl(App.thirdPartyLicenseUrl),
    );
  }
}

class _PrivacyPolicyTile extends StatelessWidget {
  const _PrivacyPolicyTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.privacy_tip_rounded,
      titleText: l10n.privacyPolicy,
      subtitleText: '${App.name} ${l10n.privacyPolicy}',
      onTap: () => App.launchUrl(App.privacyPolicyUrl),
    );
  }
}
