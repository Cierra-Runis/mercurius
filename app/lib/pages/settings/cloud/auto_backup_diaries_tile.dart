part of 'cloud_section.dart';

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
