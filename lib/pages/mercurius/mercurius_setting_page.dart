import 'package:mercurius/index.dart';

class MercuriusSettingPage extends StatelessWidget {
  const MercuriusSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设定'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Consumer<MercuriusProfileNotifier>(
              builder: (context, mercuriusProfileNotifier, child) {
                return ListTile(
                  leading: const Icon(Icons.dark_mode_rounded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('深色模式'),
                      Text(
                        mercuriusProfileNotifier.profile.themeMode ==
                                ThemeMode.system
                            ? '跟随系统'
                            : mercuriusProfileNotifier.profile.themeMode ==
                                    ThemeMode.dark
                                ? '常暗模式'
                                : '常亮模式',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.navigate_next),
                  onTap: () => _themeSelectorDialog(context),
                );
              },
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
