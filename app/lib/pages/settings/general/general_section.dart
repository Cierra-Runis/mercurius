import 'package:mercurius/index.dart';

export 'style/style_page.dart';

part 'account_tile.dart';
part 'cache_cleaning_tile.dart';
part 'language_select_tile.dart';
part 'style_tile.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.generalSettings,
      children: const [
        _AccountTile(),
        _StyleTile(),
        _LanguageSelectTile(),
        _CacheCleaningTile(),
      ],
    );
  }
}
