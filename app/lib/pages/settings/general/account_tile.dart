part of 'general_section.dart';

class _AccountTile extends StatelessWidget {
  const _AccountTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BasedListTile(
      leadingIcon: Icons.account_circle_rounded,
      titleText: l10n.account,
      onTap: () => context.push(const AccountPage()),
    );
  }
}
