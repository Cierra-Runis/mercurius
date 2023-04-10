import 'package:mercurius/index.dart';

class DialogAboutWidget extends StatelessWidget {
  const DialogAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MercuriusSudokuPage(),
              ),
            ),
            icon: Container(
              width: 48,
              height: 48,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/icon/icon.png'),
                ),
                shadows: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 15.0,
                    spreadRadius: 4.0,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Text(
                'Mercurius',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Saira',
                ),
              ),
              Consumer<MercuriusProfileNotifier>(
                builder: (context, mercuriusProfileNotifier, child) {
                  return Row(
                    children: [
                      Text(
                        '${mercuriusProfileNotifier.profile.currentVersion}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Saira',
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(2)),
                      const MercuriusOriginalVersionNoticeWidget(),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        child: MercuriusModifiedList(
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
                MercuriusModifiedListItem(
                  iconData: Icons.import_contacts_rounded,
                  titleText: '引用声明',
                  summaryText: '字体、图标相关',
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const DialogImportDeclarationWidget(),
                  ),
                ),
                MercuriusModifiedListItem(
                  iconData: Icons.privacy_tip_rounded,
                  titleText: '隐私政策',
                  summaryText: 'Mercurius 隐私政策',
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const DialogPrivacyWidget(),
                  ),
                ),
                MercuriusModifiedListItem(
                  iconData: Icons.bookmark,
                  titleText: '用户协议',
                  summaryText: 'Mercurius 用户协议',
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const DialogAgreementWidget(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('返回'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
}
