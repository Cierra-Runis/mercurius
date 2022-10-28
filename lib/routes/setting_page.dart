import 'package:mercurius/index.dart';

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
            Consumer<ThemeModel>(
              builder: (context, themeModel, child) {
                return ListTile(
                  leading: const Icon(Icons.dark_mode_rounded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('深色模式'),
                      Text(
                        themeModel.themeMode == ThemeMode.system
                            ? '跟随系统'
                            : themeModel.themeMode == ThemeMode.dark
                                ? '常暗模式'
                                : '常亮模式',
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? Colors.white54
                                  : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => _themeSelectorDialog(context),
                );
              },
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
