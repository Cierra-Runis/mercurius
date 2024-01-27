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
      body: Column(
        children: [
          BasedRadioListTile<Locale?>(
            value: null,
            groupValue: settings.locale,
            titleText: l10n.followTheSystem,
            onChanged: setSettings.setLocale,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: L10N.delegate.supportedLocales.length,
              itemBuilder: (context, index) {
                final lang = Language.values.firstWhere(
                  (e) => e.locale == L10N.delegate.supportedLocales[index],
                );
                return BasedRadioListTile<Locale>(
                  value: L10N.delegate.supportedLocales[index],
                  groupValue: settings.locale,
                  titleText: '${lang.humanName} (${lang.locale})',
                  onChanged: setSettings.setLocale,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
