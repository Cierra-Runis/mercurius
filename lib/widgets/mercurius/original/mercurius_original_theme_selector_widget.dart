import 'package:mercurius/index.dart';

class MercuriusOriginalThemeSelectorWidget extends StatelessWidget {
  const MercuriusOriginalThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MercuriusProfileNotifier>(
      builder: (_, mercuriusProfileNotifier, child) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.all(0),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('跟随系统'),
              onPressed: () {
                mercuriusProfileNotifier.changeProfile(
                  mercuriusProfileNotifier.profile
                    ..themeMode = ThemeMode.system,
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('常暗模式'),
              onPressed: () {
                mercuriusProfileNotifier.changeProfile(
                  mercuriusProfileNotifier.profile..themeMode = ThemeMode.dark,
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('常亮模式'),
              onPressed: () {
                mercuriusProfileNotifier.changeProfile(
                  mercuriusProfileNotifier.profile..themeMode = ThemeMode.light,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
