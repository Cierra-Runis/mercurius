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

class _FontPage extends HookConsumerWidget {
  const _FontPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
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
              return _FontTile(font: font);
            },
          ),
          error: (error, stackTrace) => Text(l10n.releasePageOops),
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

class _FontTile extends HookConsumerWidget {
  const _FontTile({
    required this.font,
  });

  final Font font;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);
    final paths = ref.watch(pathsProvider);
    final cacheSize = useBytes(
      Directory(
        p.join(paths.font.path, font.fontFamily),
      ),
    );
    final l10n = context.l10n;
    final l10nName = font.l10nName(context.languageTag);
    final l10nDescription = font.l10nDescription(context.languageTag);

    return ExpansionTile(
      // value: font.fontFamily,
      // groupValue: settings.fontFamily,
      // toggleable: true,
      // onChanged: setSettings.setFontFamily,
      title: Wrap(
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: [
          Text(l10nName),
          BasedBadge(
            label: Text(
              l10n.occupiedBytes(Bytes.format(bytes: cacheSize.data)),
            ),
            onPressed: () {
              setSettings.setFontFamily(null);
              FontsLoader.deleteFont(font, paths.font);
            },
          ),
          BasedBadge(
            label: Text(l10n.variantCount(font.files.length)),
            onPressed: () => setSettings.setFontFamily(font.fontFamily),
          ),
          BasedBadge(
            label: Text(l10n.officialWebsite),
            onPressed: () => App.launchUrl(font.website),
          ),
          BasedBadge(
            label: Text(font.license.type),
            onPressed: () => App.launchUrl(font.license.link),
          ),
        ],
      ),
      subtitle: Text(
        l10nDescription,
        style: TextStyle(
          fontSize: App.fontSize12,
          color: context.colorScheme.outline,
        ),
      ),
      children: font.files.map((e) => ListTile(title: Text(e))).toList(),
      // secondary: IconButton(
      //   onPressed: () {
      //     setSettings.setFontFamily(null);
      //     FontsLoader.deleteFont(font, paths.font);
      //   },
      //   icon: Icon(
      //     Icons.delete_rounded,
      //     color: context.colorScheme.error,
      //   ),
      // ),
    );
  }
}
