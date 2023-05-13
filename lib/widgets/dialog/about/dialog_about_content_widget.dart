import 'package:mercurius/index.dart';

class DialogAboutContentWidget extends StatelessWidget {
  const DialogAboutContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> data = [
      [
        Icons.import_contacts_rounded,
        '引用声明',
        '字体、图标相关',
        MercuriusJsonToDialogWidget(
          jsonPath: 'assets/json/declaration.json',
          onTapLink: (_, link, href, __) =>
              _showDialogLicenseWidget(context, link[href]),
        ),
      ],
      [
        Icons.privacy_tip_rounded,
        '隐私政策',
        '${MercuriusConstance.name} 隐私政策',
        const MercuriusJsonToDialogWidget(jsonPath: 'assets/json/privacy.json')
      ],
      [
        Icons.bookmark,
        '用户协议',
        '${MercuriusConstance.name} 用户协议',
        const MercuriusJsonToDialogWidget(
          jsonPath: 'assets/json/agreement.json',
        ),
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
              summaryText: MercuriusConstance.contactUrl,
              onTap: () => launchUrlString(
                MercuriusConstance.contactUrl,
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
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  license,
                  style: const TextStyle(
                    fontFamily: 'Saira',
                    fontSize: 6,
                  ),
                ),
              ],
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
