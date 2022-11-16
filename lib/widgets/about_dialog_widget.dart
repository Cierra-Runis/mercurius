import 'package:mercurius/index.dart';

const String _url = 'https://github.com/Cierra-Runis/';

class AboutDialogWidget extends StatefulWidget {
  const AboutDialogWidget({super.key});

  @override
  State<AboutDialogWidget> createState() => _AboutDialogWidgetState();
}

class _AboutDialogWidgetState extends State<AboutDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                DevTools.printLog('[007] 彩蛋🎉️');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SudokuPage(),
                  ),
                );
              },
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
                  fontFamily: 'cmdysj',
                ),
              ),
              Row(
                children: [
                  Text(
                    profileModel.profile.currentVersion!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'cmdysj',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(2),
                  ),
                  profileModel.profile.currentVersion !=
                          mercuriusWebModel.githubLatestRelease.tag_name
                      ? TextButton(
                          onPressed: () {
                            DevTools.printLog('已是最新');
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.all(1.5),
                            minimumSize: const Size(20, 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            '已是最新版本',
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            DevTools.printLog('开始下载');
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(1.5),
                            minimumSize: const Size(20, 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            '更新至新版本',
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ),
                        ),
                ],
              )
            ],
          ),
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.link),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('联系我们'),
                Text(
                  _url,
                  style: TextStyle(
                    fontSize: 8,
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.white54
                        : Colors.black54,
                  ),
                ),
              ],
            ),
            onTap: () {
              launchUrlString(
                _url,
                mode: LaunchMode.inAppWebView,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.import_contacts_rounded),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('引用声明'),
                Text(
                  '字体、图标相关',
                  style: TextStyle(
                    fontSize: 8,
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.white54
                        : Colors.black54,
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
              children: <Widget>[
                const Text('隐私政策'),
                Text(
                  'Mercurius 隐私政策',
                  style: TextStyle(
                    fontSize: 8,
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.white54
                        : Colors.black54,
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
              children: <Widget>[
                const Text('用户协议'),
                Text(
                  'Mercurius 用户协议',
                  style: TextStyle(
                    fontSize: 8,
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.white54
                        : Colors.black54,
                  ),
                ),
              ],
            ),
            onTap: () => _agreementDialog(context),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('返回'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
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
