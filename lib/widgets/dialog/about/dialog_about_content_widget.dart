import 'package:mercurius/index.dart';

class DialogAboutContentWidget extends StatelessWidget {
  const DialogAboutContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return BasedListView(
      children: [
        BasedListSection(
          margin: EdgeInsets.zero,
          children: [
            BasedListTile(
              leadingIcon: Icons.link,
              titleText: l10n.contactUs,
              subtitleText: Mercurius.contactUrl,
              onTap: () {
                try {
                  launchUrlString(
                    Mercurius.contactUrl,
                    mode: LaunchMode.externalApplication,
                  );
                } catch (e) {
                  Mercurius.printLog(
                    'launch ${Mercurius.contactUrl} failed: $e',
                  );
                }
              },
            ),
            BasedListTile(
              leadingIcon: Icons.import_contacts_rounded,
              titleText: l10n.importDeclaration,
              subtitleText: l10n.importDeclarationDescription,
              onTap: () => showDialog(
                context: context,
                builder: (context) => MercuriusJsonToDialogWidget(
                  title: l10n.importDeclaration,
                  updateTime: l10n.importDeclarationContentUpdateTime,
                  content: l10n.importDeclarationContent,
                ),
              ),
            ),
            BasedListTile(
              leadingIcon: Icons.privacy_tip_rounded,
              titleText: l10n.privacyStatement,
              subtitleText: '${Mercurius.name} ${l10n.privacyStatement}',
              onTap: () => showDialog(
                context: context,
                builder: (context) => MercuriusJsonToDialogWidget(
                  title: l10n.privacyStatement,
                  updateTime: l10n.privacyStatementContentUpdateTime,
                  content: l10n.privacyStatementContent,
                ),
              ),
            ),
          ],
        )
      ],
    ).adaptAlertDialog;
  }
}
