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
        showDragHandle: true,
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
          onTap: () => FlutterDisplayMode.setPreferredMode(displayMode),
        );
      },
    );
  }
}
