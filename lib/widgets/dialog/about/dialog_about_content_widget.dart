import 'package:mercurius/index.dart';

class DialogAboutContentWidget extends StatelessWidget {
  const DialogAboutContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> data = [
      [
        Icons.import_contacts_rounded,
        '引用声明',
        '字体、图标、天气服务相关',
        const MercuriusJsonToDialogWidget(
          jsonPath: 'assets/json/declaration.json',
        ),
      ],
      [
        Icons.privacy_tip_rounded,
        '隐私政策',
        '${Mercurius.name} 隐私政策',
        const MercuriusJsonToDialogWidget(
          jsonPath: 'assets/json/privacy.json',
        )
      ],
    ];

    List<Widget> list = [];
    for (List<dynamic> element in data) {
      list.add(
        MercuriusListItemWidget(
          iconData: element[0],
          titleText: element[1],
          summaryText: element[2],
          onTap: () {
            showDialog(context: context, builder: (context) => element[3]);
          },
        ),
      );
    }

    return MercuriusListWidget(
      shrinkWrap: true,
      children: [
        MercuriusListSectionWidget(
          margin: EdgeInsets.zero,
          children: [
            MercuriusListItemWidget(
              iconData: Icons.link,
              titleText: '联系我们',
              summaryText: Mercurius.contactUrl,
              onTap: () => launchUrlString(
                Mercurius.contactUrl,
                mode: LaunchMode.externalApplication,
              ),
            ),
            ...list,
          ],
        )
      ],
    );
  }

  Future<void> _showDialogLicenseWidget(BuildContext context, String license) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Markdown(
              data: license,
              shrinkWrap: true,
              onTapLink: (text, href, title) {
                if (href != null) {
                  launchUrlString(
                    href,
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              styleSheet: MarkdownStyleSheet(
                textScaleFactor: 0.5,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        );
      },
    );
  }
}
