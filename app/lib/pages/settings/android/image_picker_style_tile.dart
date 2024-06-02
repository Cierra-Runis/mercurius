part of 'android_section.dart';

/// https://developer.android.com/training/data-storage/shared/photopicker
class _ImagePickerStyleTile extends ConsumerWidget {
  const _ImagePickerStyleTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return BasedSwitchListTile(
      value: settings.useAndroid13PhotoPicker,
      onChanged: setSettings.setUseAndroid13PhotoPicker,
      titleText: l10n.imagePicker,
      subtitleText: l10n.useAndroid13PhotoPicker,
      leadingIcon: Icons.photo_album_rounded,
    );
  }
}
