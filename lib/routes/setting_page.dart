import 'package:mercurius/widgets/index.dart';

import 'index.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设定'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.dark_mode_rounded),
              title: const Text('深色模式'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () => _themeSelectorDialog(context),
            ),
            const Divider(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _themeSelectorDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const ThemeSelectorWidget();
      },
    );
  }
}
