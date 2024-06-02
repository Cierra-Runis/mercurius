part of 'cloud_section.dart';

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
