part of 'general_section.dart';

class _FontSelectTile extends ConsumerWidget {
  const _FontSelectTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);

    return BasedListTile(
      leadingIcon: Icons.text_format_rounded,
      titleText: l10n.font,
      detailText: settings.fontFamily ?? l10n.followTheSystem,
      onTap: () => context.push(const _FontPage()),
    );
  }
}

class _FontPage extends ConsumerWidget {
  const _FontPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);
    final paths = ref.watch(pathsProvider);
    final snapshot = ref.watch(fontsManifestProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.font),
      ),
      body: Center(
        child: snapshot.when(
          skipLoadingOnRefresh: false,
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final font = data[index];
              final l10nName = font.l10nName(context.languageTag);
              final l10nDescription = font.l10nDescription(context.languageTag);

              return RadioListTile(
                value: font.fontFamily,
                groupValue: settings.fontFamily,
                toggleable: true,
                title: Text(l10nName),
                subtitle: Text(l10nDescription),
                onChanged: setSettings.setFontFamily,
                secondary: IconButton(
                  onPressed: () => FontsLoader.deleteFont(font, paths.font),
                  icon: Icon(
                    Icons.delete_rounded,
                    color: context.colorScheme.error,
                  ),
                ),
              );
            },
          ),
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const Loading(),
        ),
      ),
      floatingActionButton: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FloatingActionButton.small(
            heroTag: 'refresh',
            onPressed: () => ref.refresh(fontsManifestProvider),
            child: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }
}
