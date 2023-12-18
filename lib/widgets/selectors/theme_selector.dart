import 'package:mercurius/index.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.current;
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return SegmentedButton<ThemeMode>(
      showSelectedIcon: false,
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        visualDensity: VisualDensity.compact,
      ),
      segments: [
        ButtonSegment(
          value: ThemeMode.system,
          tooltip: l10n.followTheSystem,
          label: Icon(Settings.themeModeIcon[ThemeMode.system]),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          tooltip: l10n.alwaysDark,
          label: Icon(Settings.themeModeIcon[ThemeMode.dark]),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          tooltip: l10n.alwaysBright,
          label: Icon(Settings.themeModeIcon[ThemeMode.light]),
        ),
      ],
      selected: {settings.themeMode},
      onSelectionChanged: (p0) => settingsNotifier.setThemeMode(p0.first),
    );
  }
}
