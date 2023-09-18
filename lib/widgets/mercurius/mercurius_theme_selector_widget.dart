import 'package:mercurius/index.dart';

class MercuriusThemeSelectorWidget extends ConsumerWidget {
  const MercuriusThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                )
              ],
              selected: {snapshot.data!.themeMode},
              onSelectionChanged: (p0) =>
                  isarService.saveConfig(snapshot.data!..themeMode = p0.first),
            ),
          );
        }
        return const MercuriusLoadingWidget();
      },
    );
  }
}
