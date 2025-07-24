part of 'general_section.dart';

class _LanguagePage extends ConsumerWidget {
  const _LanguagePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);
    final setSettings = ref.watch(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BasedRadioListTile<Locale?>(
              value: null,
              groupValue: settings.locale,
              titleText: l10n.followTheSystem,
              onChanged: setSettings.setLocale,
            ),
          ),
          SliverList.builder(
            itemCount: App.supportLanguages.length,
            itemBuilder: (context, index) {
              final MapEntry(key: locale, value: humanString) =
                  App.supportLanguages.entries.elementAt(index);
              return BasedRadioListTile<Locale>(
                value: locale,
                groupValue: settings.locale,
                titleText: '$humanString ($locale)',
                onChanged: setSettings.setLocale,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageSelectTile extends ConsumerWidget {
  const _LanguageSelectTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsProvider);

    final humanString = App.supportLanguages[settings.locale];

    return BasedListTile(
      leadingIcon: Icons.translate_rounded,
      titleText: l10n.language,
      detailText: humanString ?? l10n.followTheSystem,
      onTap: () => context.push(const _LanguagePage()),
    );
  }
}
