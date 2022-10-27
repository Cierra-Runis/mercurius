import 'index.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String _url = 'https://github.com/Cierra-Runis/';

class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key});

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Image(
            image: AssetImage('assets/icon/icon.png'),
            height: 50,
          ),
          Column(
            children: [
              Text(_packageInfo.appName),
              Text(
                _packageInfo.version,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
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
                mode: LaunchMode.externalApplication,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.import_contacts_rounded),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('素材引用'),
                Text(
                  '字体、图片相关',
                  style: TextStyle(
                    fontSize: 8,
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.white54
                        : Colors.black54,
                  ),
                )
              ],
            ),
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
      contentPadding: const EdgeInsets.all(4),
      actionsPadding: const EdgeInsets.all(8),
    );
  }

  Future<void> _privacyDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const PrivacyWidget();
      },
    );
  }

  Future<void> _agreementDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const AgreementWidget();
      },
    );
  }
}
