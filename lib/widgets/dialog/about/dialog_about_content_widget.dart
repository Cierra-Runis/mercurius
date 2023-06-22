import 'package:mercurius/index.dart';

class DialogAboutContentWidget extends StatelessWidget {
  const DialogAboutContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return MercuriusListWidget(
      shrinkWrap: true,
      children: [
        MercuriusListSectionWidget(
          margin: EdgeInsets.zero,
          children: [
            MercuriusListItemWidget(
              iconData: Icons.link,
              titleText: l10n.contactUs,
              summaryText: Mercurius.contactUrl,
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
            MercuriusListItemWidget(
              iconData: Icons.import_contacts_rounded,
              titleText: l10n.importDeclaration,
              summaryText: l10n.importDeclarationDescription,
              onTap: () => showDialog(
                context: context,
                builder: (context) => MercuriusJsonToDialogWidget(
                  title: l10n.importDeclaration,
                  updateTime: l10n.importDeclarationContentUpdateTime,
                  content: l10n.importDeclarationContent,
                ),
              ),
            ),
            MercuriusListItemWidget(
              iconData: Icons.privacy_tip_rounded,
              titleText: l10n.privacyStatement,
              summaryText: '${Mercurius.name} ${l10n.privacyStatement}',
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
    );
  }
}
