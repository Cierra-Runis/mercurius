import 'package:mercurius/index.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: const Center(
        child: BasedListView(
          children: [
            BasedListSection(
              children: [
                _ThemeSelectListItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSelectListItem extends ConsumerWidget {
  const _ThemeSelectListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Config config = snapshot.data!;
          return BasedListTile(
            leadingIcon: Icons.dark_mode_rounded,
            titleText: l10n.darkMode,
            detailText: config.themeMode == ThemeMode.system
                ? l10n.followTheSystem
                : snapshot.data!.themeMode == ThemeMode.dark
                    ? l10n.alwaysDark
                    : l10n.alwaysBright,
            onTap: () => showDialog<void>(
              context: context,
              builder: (context) {
                return const MercuriusThemeSelectorWidget();
              },
            ),
          );
        }
        return const MercuriusLoadingWidget();
      },
    );
  }
}
