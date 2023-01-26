import 'package:mercurius/index.dart';

import 'package:badges/badges.dart' as badge; // 小红点提示

const String _url = 'https://github.com/Cierra-Runis/';

class AboutDialogWidget extends StatelessWidget {
  const AboutDialogWidget({super.key});

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
                      builder: (context) => const SudokuPage(),
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
              )),
          Column(
            children: [
              const Text(
                'Mercurius',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Saira',
                ),
              ),
              Consumer2<MercuriusWebModel, ProfileModel>(
                builder: (context, mercuriusWebModel, profileModel, child) {
                  return Row(
                    children: [
                      Text(
                        profileModel.profile.currentVersion!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Saira',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      profileModel.profile.currentVersion !=
                              mercuriusWebModel.githubLatestRelease.tag_name
                          ? TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GithubLatestReleasePage(),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.all(1.5),
                                minimumSize: const Size(20, 10),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: badge.Badge(
                                child: const Text(
                                  '更新至新版本',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: () => mercuriusWebModel
                                  .refetchGithubLatestRelease(),
                              onLongPress: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GithubLatestReleasePage(),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.all(1.5),
                                minimumSize: const Size(20, 10),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                '已是最新版本',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 8),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.link),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('联系我们'),
                Text(
                  _url,
                  style: TextStyle(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            onTap: () => launchUrlString(
              _url,
              mode: LaunchMode.externalApplication,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.import_contacts_rounded),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('引用声明'),
                Text(
                  '字体、图标相关',
                  style: TextStyle(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                )
              ],
            ),
            onTap: () => _importDeclarationDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_rounded),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('隐私政策'),
                Text(
                  'Mercurius 隐私政策',
                  style: TextStyle(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            onTap: () => _privacyDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('用户协议'),
                Text(
                  'Mercurius 用户协议',
                  style: TextStyle(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
            onTap: () => _agreementDialog(context),
          ),
        ],
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

  Future<void> _importDeclarationDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const ImportDeclarationDialogWidget();
      },
    );
  }

  Future<void> _privacyDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const PrivacyDialogWidget();
      },
    );
  }

  Future<void> _agreementDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AgreementDialogWidget();
      },
    );
  }
}
