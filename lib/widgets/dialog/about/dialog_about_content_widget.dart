import 'package:mercurius/index.dart';

class DialogAboutContentWidget extends StatelessWidget {
  const DialogAboutContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    return MercuriusListWidget(
      shrinkWrap: true,
      children: [
        MercuriusListSectionWidget(
          margin: EdgeInsets.zero,
          children: [
            MercuriusListItemWidget(
              iconData: Icons.link,
              titleText: localizations.contactUs,
              summaryText: Mercurius.contactUrl,
              onTap: () => launchUrlString(
                Mercurius.contactUrl,
                mode: LaunchMode.externalApplication,
              ),
            ),
            MercuriusListItemWidget(
              iconData: Icons.import_contacts_rounded,
              titleText: localizations.importDeclaration,
              summaryText: localizations.importDeclarationDescription,
              onTap: () => showDialog(
                context: context,
                builder: (context) => MercuriusJsonToDialogWidget(
                  title: localizations.importDeclaration,
                  updateTime: localizations.importDeclarationContentUpdateTime,
                  content: localizations.importDeclarationContent,
                ),
              ),
            ),
            MercuriusListItemWidget(
              iconData: Icons.privacy_tip_rounded,
              titleText: localizations.privacyStatement,
              summaryText:
                  '${Mercurius.name} ${localizations.privacyStatement}',
              onTap: () => showDialog(
                context: context,
                builder: (context) => MercuriusJsonToDialogWidget(
                  title: localizations.privacyStatement,
                  updateTime: localizations.privacyStatementContentUpdateTime,
                  content: localizations.privacyStatementContent,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
