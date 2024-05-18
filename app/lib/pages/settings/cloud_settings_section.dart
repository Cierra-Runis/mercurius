import 'package:mercurius/index.dart';

class CloudSettingsSection extends StatelessWidget {
  const CloudSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const BasedListSection(
      titleText: '云端设置',
      children: [
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
    return BasedListTile(
      titleText: 'GitHub 设定',
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
                  initialValue: settings.gitHubSlugOwner,
                  onSaved: setSettings.setGitHubSlugOwner,
                  decoration: const InputDecoration(
                    icon: Icon(UniconsLine.github),
                    label: Text('GitHub 用户名称'),
                  ),
                ),
              ),
              ListTile(
                title: TextFormField(
                  initialValue: settings.gitHubSlugName,
                  onSaved: setSettings.setGitHubSlugName,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.cabin_rounded),
                    label: Text('GitHub 仓库名称'),
                  ),
                ),
              ),
              ListTile(
                title: TextFormField(
                  initialValue: settings.gitHubToken,
                  onSaved: setSettings.setGitHubToken,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.token_rounded),
                    label: Text('GitHub TOKEN'),
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
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return BasedSwitchListTile(
      value: settings.autoUploadImages,
      onChanged: setSettings.setAutoUploadImages,
      leadingIcon: Icons.backup_rounded,
      titleText: '自动上传图片',
    );
  }
}

class _AutoBackupDiariesTile extends ConsumerWidget {
  const _AutoBackupDiariesTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return BasedSwitchListTile(
      value: settings.autoBackupDiaries,
      onChanged: setSettings.setAutoBackupDiaries,
      titleText: '自动备份日记',
      leadingIcon: Icons.backup_rounded,
    );
  }
}
