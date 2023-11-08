import 'package:mercurius/index.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return AlertDialog(
      content: SegmentedButton<ThemeMode>(
        segments: [
          ButtonSegment(
            value: ThemeMode.system,
            label: Text(l10n.followTheSystem),
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            label: Text(l10n.alwaysDark),
          ),
          ButtonSegment(
            value: ThemeMode.light,
            label: Text(l10n.alwaysBright),
          ),
        ],
        selected: {settings.themeMode},
        onSelectionChanged: (p0) => settingsNotifier.setThemeMode(p0.first),
      ),
    );
  }
}
