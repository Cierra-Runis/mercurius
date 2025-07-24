part of 'general_section.dart';

class _ThemeSelector extends ConsumerWidget {
  const _ThemeSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return SegmentedButton<ThemeMode>(
      showSelectedIcon: false,
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      segments: [
        ButtonSegment(
          value: ThemeMode.system,
          tooltip: l10n.followTheSystem,
          label: Icon(App.themeModeIcon[ThemeMode.system]),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          tooltip: l10n.alwaysDark,
          label: Icon(App.themeModeIcon[ThemeMode.dark]),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          tooltip: l10n.alwaysBright,
          label: Icon(App.themeModeIcon[ThemeMode.light]),
        ),
      ],
      selected: {settings.themeMode},
      onSelectionChanged: (p0) => settingsNotifier.setThemeMode(p0.first),
    );
  }
}

class _ThemeSelectTile extends StatelessWidget {
  const _ThemeSelectTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.dark_mode_rounded,
      titleText: l10n.darkMode,
      trailing: const _ThemeSelector(),
    );
  }
}
