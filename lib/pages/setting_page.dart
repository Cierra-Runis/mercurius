import 'package:mercurius/index.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
                _BackgroundImageListTile(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundImageListTile extends StatelessWidget {
  const _BackgroundImageListTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return StreamBuilder(
      stream: isarService.listenToConfig(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Config config = snapshot.data!;
          return BasedListTile(
            leadingIcon: Icons.flip_to_back_rounded,
            titleText: l10n.backgroundImage,
            detailText: config.backgroundImagePath ?? l10n.noImageSelected,
            onTap: () async {
              String? path = await context.push(
                const GalleryPage(readOnly: true),
              );
              Mercurius.printLog(path);
              isarService.saveConfig(config..backgroundImagePath = path);
            },
          );
        }
        return const MercuriusLoadingWidget();
      },
    );
  }
}

class _ThemeSelectListItem extends ConsumerWidget {
  const _ThemeSelectListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

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
              builder: (context) => const MercuriusThemeSelectorWidget(),
            ),
          );
        }
        return const MercuriusLoadingWidget();
      },
    );
  }
}
