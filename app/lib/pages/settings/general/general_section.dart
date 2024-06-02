import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

part 'accent_color_tile.dart';
part 'background_image_tile.dart';
part 'cache_cleaning_tile.dart';
part 'font_select_tile.dart';
part 'language_select_tile.dart';
part 'theme_select_tile.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.generalSettings,
      children: const [
        _ThemeSelectTile(),
        _AccentColorTile(),
        _BackgroundImageTile(),
        _LanguageSelectTile(),
        _FontSelectTile(),
        _CacheCleaningTile(),
      ],
    );
  }
}
