import 'package:mercurius/index.dart';

class CloudSettingsSection extends StatelessWidget {
  const CloudSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BasedListSection(
      titleText: l10n.cloudSettings,
      children: const [
        _GitHubSettingsTile(),
        _AutoUploadImagesTile(),
        _AutoBackupDiariesTile(),
      ],
    );
  }
}

class _GitHubSettingsTile extends StatelessWidget {
  const _GitHubSettingsTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BasedListTile(
      titleText: l10n.gitHubSettings,
      leadingIcon: UniconsLine.github,
      onTap: () => context.pushDialog(const _GitHubSettingsPage()),
    );
  }
}

class _GitHubSettingsPage extends HookConsumerWidget {
  const _GitHubSettingsPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final formKey = useMemoized(GlobalKey<FormState>.new);

    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: formKey,
          child: BasedListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: TextFormField(
                  initialValue: settings.gitHubOwner,
                  onSaved: setSettings.setGitHubOwner,
                  decoration: InputDecoration(
                    icon: const Icon(UniconsLine.github),
                    label: Text(l10n.gitHubUsername),
                  ),
                ),
              ),
              ListTile(
                title: TextFormField(
                  initialValue: settings.gitHubRepo,
                  onSaved: setSettings.setGitHubRepo,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.cabin_rounded),
                    label: Text(l10n.githubRepoName),
                  ),
                ),
              ),
              ListTile(
                title: TextFormField(
                  initialValue: settings.gitHubToken,
                  onSaved: setSettings.setGitHubToken,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.token_rounded),
                    label: Text(l10n.gitHubToken),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            formKey.currentState?.save();
            context.pop();
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }
}

class _AutoUploadImagesTile extends ConsumerWidget {
  const _AutoUploadImagesTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return BasedSwitchListTile(
      value: settings.autoUploadImages,
      onChanged: setSettings.setAutoUploadImages,
      leadingIcon: Icons.backup_rounded,
      titleText: l10n.autoUploadImages,
    );
  }
}

class _AutoBackupDiariesTile extends ConsumerWidget {
  const _AutoBackupDiariesTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return BasedSwitchListTile(
      value: settings.autoBackupDiaries,
      onChanged: setSettings.setAutoBackupDiaries,
      titleText: l10n.autoBackupDiaries,
      leadingIcon: Icons.backup_rounded,
    );
  }
}
