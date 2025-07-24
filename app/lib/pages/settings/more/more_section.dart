import 'package:mercurius/index.dart';

class MoreSection extends StatelessWidget {
  const MoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BasedListSection(
      titleText: l10n.morePage,
      children: [
        _StatisticTile(),
        _ImageGalleryTile(),
        _IOTile(),
      ],
    );
  }
}

class _ImageGalleryTile extends StatelessWidget {
  const _ImageGalleryTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.image_rounded,
      titleText: l10n.imageGallery,
      onTap: () => context.push(const GalleryPage()),
    );
  }
}

class _IOTile extends StatelessWidget {
  const _IOTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.import_export_rounded,
      titleText: l10n.importAndExport,
      onTap: () => context.push(const IOPage()),
    );
  }
}

class _StatisticTile extends StatelessWidget {
  const _StatisticTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.analytics_rounded,
      titleText: l10n.statistics,
      onTap: () => context.push(const StatisticPage()),
    );
  }
}
