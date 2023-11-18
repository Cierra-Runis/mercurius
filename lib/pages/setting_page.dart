import 'package:mercurius/index.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.current;

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

class _BackgroundImageListTile extends ConsumerWidget {
  const _BackgroundImageListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.current;
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return BasedListTile(
      leadingIcon: Icons.flip_to_back_rounded,
      titleText: l10n.backgroundImage,
      detailText: settings.bgImgPath ?? l10n.noImageSelected,
      onTap: () async {
        final path = await context.push<String?>(
          const GalleryPage(readOnly: true),
        );
        settingsNotifier.setBgImgPath(path);
      },
    );
  }
}

class _ThemeSelectListItem extends ConsumerWidget {
  const _ThemeSelectListItem();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.current;
    final settings = ref.watch(settingsProvider);

    return BasedListTile(
      leadingIcon: Icons.dark_mode_rounded,
      titleText: l10n.darkMode,
      detailText: settings.themeMode == ThemeMode.system
          ? l10n.followTheSystem
          : settings.themeMode == ThemeMode.dark
              ? l10n.alwaysDark
              : l10n.alwaysBright,
      onTap: () => context.pushDialog(
        const ThemeSelector(),
      ),
    );
  }
}
