import 'package:mercurius/index.dart';

part 'display_settings_tile.dart';
part 'image_picker_style_tile.dart';

class AndroidSection extends StatelessWidget {
  const AndroidSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListSection(
      titleText: l10n.androidPlatformSpecificSettings,
      children: const [
        _DisplaySettingsTile(),
        _ImagePickerStyleTile(),
      ],
    );
  }
}
