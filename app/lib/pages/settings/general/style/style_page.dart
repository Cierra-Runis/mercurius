import 'package:mercurius/index.dart';
import 'package:path/path.dart' as p;

part 'accent_color_tile.dart';
part 'background_image_tile.dart';
part 'font_select_tile.dart';
part 'theme_select_tile.dart';

class StylePage extends StatelessWidget {
  const StylePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.style),
      ),
      body: BasedListView(
        children: [
          _ThemeSelectTile(),
          _AccentColorTile(),
          _FontSelectTile(),
          _BackgroundImageTile(),
        ],
      ),
    );
  }
}
