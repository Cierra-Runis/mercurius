import 'package:mercurius/index.dart';

class ThemeSelectorWidget extends StatelessWidget {
  const ThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// 利用 `provide` 包进行状态管理
    return Consumer<ProfileModel>(
      builder: (_, profileModel, child) {
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
                profileModel.changeProfile(
                  profileModel.profile..themeMode = ThemeMode.system,
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
                profileModel.changeProfile(
                  profileModel.profile..themeMode = ThemeMode.dark,
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
                profileModel.changeProfile(
                  profileModel.profile..themeMode = ThemeMode.light,
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
