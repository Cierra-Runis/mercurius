import 'package:mercurius/index.dart';

class MercuriusOriginalAboutDialogContentWidget extends StatelessWidget {
  const MercuriusOriginalAboutDialogContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> data = [
      [
        Icons.import_contacts_rounded,
        '引用声明',
        '字体、图标相关',
        const DialogDeclarationWidget()
      ],
      [
        Icons.privacy_tip_rounded,
        '隐私政策',
        '${MercuriusConstance.name} 隐私政策',
        const DialogPrivacyWidget()
      ],
      [
        Icons.bookmark,
        '用户协议',
        '${MercuriusConstance.name} 用户协议',
        const DialogAgreementWidget()
      ],
    ];

    List<Widget> list = [];
    for (List<dynamic> element in data) {
      list.add(
        MercuriusModifiedListItem(
          iconData: element[0],
          titleText: element[1],
          summaryText: element[2],
          onTap: () {
            showDialog(context: context, builder: (context) => element[3]);
          },
        ),
      );
    }

    return MercuriusModifiedList(
      shrinkWrap: true,
      children: [
        MercuriusModifiedListSection(
          margin: EdgeInsets.zero,
          children: [
            MercuriusModifiedListItem(
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
}
