import 'package:mercurius/index.dart';

class AndroidSettingsSection extends StatelessWidget {
  const AndroidSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.androidPlatformSpecificSettings,
      children: const [
        _DisplaySettings(),
        _ImagePickerStyleTile(),
      ],
    );
  }
}

class _DisplaySettings extends HookWidget {
  const _DisplaySettings();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final snapshot = useFuture(FlutterDisplayMode.active);

    return BasedListTile(
      leadingIcon: Icons.display_settings_rounded,
      titleText: l10n.displayMode,
      subtitleText: '${snapshot.data ?? ''}',
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) => const _DisplaySettingsSheet(),
      ),
    );
  }
}

class _DisplaySettingsSheet extends HookWidget {
  const _DisplaySettingsSheet();

  @override
  Widget build(BuildContext context) {
    final snapshot = useFuture(FlutterDisplayMode.supported);
    final displayModes = snapshot.data;

    if (displayModes == null || displayModes.isEmpty) {
      return const Center(child: Loading());
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: displayModes.length,
      itemBuilder: (context, index) {
        final displayMode = displayModes[index];
        return BasedListTile(
          leadingIcon: Icons.display_settings_rounded,
          titleText: '$displayMode',
          onTap: () {
            FlutterDisplayMode.setPreferredMode(displayMode);
            context.pop();
          },
        );
      },
    );
  }
}

/// https://developer.android.com/training/data-storage/shared/photopicker
class _ImagePickerStyleTile extends ConsumerWidget {
  const _ImagePickerStyleTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return BasedSwitchListTile(
      value: settings.useAndroid13PhotoPicker,
      onChanged: setSettings.setUseAndroid13PhotoPicker,
      titleText: '图片选择器',
      subtitleText: '使用 Android 13 及以上新样式',
      leadingIcon: Icons.photo_album_rounded,
    );
  }
}
