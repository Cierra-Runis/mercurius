import 'package:mercurius/index.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

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
              final MapEntry(key: humanString, value: locale) =
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
