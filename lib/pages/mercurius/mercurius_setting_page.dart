import 'package:mercurius/index.dart';

class MercuriusSettingPage extends StatelessWidget {
  const MercuriusSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.settings),
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
    final S localizations = S.of(context);

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Config config = snapshot.data!;
          return MercuriusListItemWidget(
            iconData: Icons.dark_mode_rounded,
            titleText: localizations.darkMode,
            detailText: config.themeMode == ThemeMode.system
                ? localizations.followTheSystem
                : snapshot.data?.themeMode == ThemeMode.dark
                    ? localizations.alwaysDark
                    : localizations.alwaysBright,
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
    final S localizations = S.of(context);

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Config config = snapshot.data!;
          return MercuriusModifiedListSwitchItem(
            iconData: Icons.vibration,
            titleText: localizations.buttonVibration,
            detailText: config.buttonVibration
                ? localizations.enabled
                : localizations.disabled,
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
