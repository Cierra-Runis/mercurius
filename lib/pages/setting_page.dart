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
        child: MercuriusListWidget(
          children: [
            MercuriusListSectionWidget(
              children: [
                _ThemeSelectListItem(),
                _VibrationSelectListItem(),
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
          return MercuriusListItemWidget(
            iconData: Icons.dark_mode_rounded,
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

class _VibrationSelectListItem extends ConsumerWidget {
  const _VibrationSelectListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Config config = snapshot.data!;
          return MercuriusModifiedListSwitchItem(
            iconData: Icons.vibration,
            titleText: l10n.buttonVibration,
            detailText: config.buttonVibration ? l10n.enabled : l10n.disabled,
            value: config.buttonVibration,
            onChanged: (value) => isarService.saveConfig(
              config..buttonVibration = !config.buttonVibration,
            ),
          );
        }
        return const MercuriusLoadingWidget();
      },
    );
  }
}
