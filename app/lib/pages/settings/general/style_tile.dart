part of 'general_section.dart';

class _StyleTile extends StatelessWidget {
  const _StyleTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.style_rounded,
      titleText: l10n.style,
      onTap: () => context.push(const StylePage()),
    );
  }
}
