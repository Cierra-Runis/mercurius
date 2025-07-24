import 'package:mercurius/index.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.aboutApp,
      children: const [
        _ReleaseTile(),
        _ContactTile(),
        _ThirdPartyLicenseTile(),
        _PrivacyPolicyTile(),
      ],
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
