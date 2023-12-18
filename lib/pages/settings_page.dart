import 'package:mercurius/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                _ThemeSelectListTile(),
                _BackgroundImageListTile(),
                _LanguageSelectListTile(),
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

    return BasedListTile(
      leadingIcon: Icons.flip_to_back_rounded,
      titleText: l10n.backgroundImage,
      detailText: settings.bgImgPath ?? l10n.noImageSelected,
      onTap: () {
        context.push(
          const GalleryPage(readOnly: true),
        );
      },
    );
  }
}

class _ThemeSelectListTile extends ConsumerWidget {
  const _ThemeSelectListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.current;

    return BasedListTile(
      leadingIcon: Icons.dark_mode_rounded,
      titleText: l10n.darkMode,
      trailing: const ThemeSelector(),
    );
  }
}

class _LanguageSelectListTile extends StatelessWidget {
  const _LanguageSelectListTile();

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.current;

    return BasedListTile(
      leadingIcon: Icons.translate_rounded,
      titleText: l10n.language,
      onTap: () => context.push(const LanguagePage()),
    );
  }
}
