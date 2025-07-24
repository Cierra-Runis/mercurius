part of 'general_section.dart';

class _BackgroundImagePage extends ConsumerWidget {
  const _BackgroundImagePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paths = ref.watch(pathsProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.backgroundImage),
        actions: [
          TextButton(
            onPressed: () => settingsNotifier.setBgImgPath(null),
            child: Text(l10n.clear),
          ),
        ],
      ),
      body: Gallery(
        directory: paths.image,
        onCardTap: (context, filename) {
          settingsNotifier.setBgImgPath(filename);
          context.pop();
        },
      ),
    );
  }
}

class _BackgroundImageTile extends ConsumerWidget {
  const _BackgroundImageTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);

    return BasedListTile(
      leadingIcon: Icons.flip_to_back_rounded,
      titleText: l10n.backgroundImage,
      detailText: settings.bgImgPath ?? l10n.noImageSelected,
      onTap: () => context.push(const _BackgroundImagePage()),
    );
  }
}
