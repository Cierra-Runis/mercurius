import 'package:mercurius/index.dart';

part 'auto_backup_diaries_tile.dart';

part 'auto_upload_images_tile.dart';
part 'github_settings_tile.dart';

class CloudSection extends StatelessWidget {
  const CloudSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BasedListSection(
      titleText: l10n.cloudSettings,
      children: const [
        _GitHubSettingsTile(),
        _AutoUploadImagesTile(),
        _AutoBackupDiariesTile(),
      ],
    );
  }
}
