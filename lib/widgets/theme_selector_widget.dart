import 'package:mercurius/index.dart';

class ThemeSelectorWidget extends StatefulWidget {
  const ThemeSelectorWidget({super.key});

  @override
  State<ThemeSelectorWidget> createState() => _ThemeSelectorWidgetState();
}

class _ThemeSelectorWidgetState extends State<ThemeSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (_, themeModel, child) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.all(0),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('跟随系统'),
            onPressed: () {
              themeModel.changeThemeMode(ThemeMode.system);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('常暗模式'),
            onPressed: () {
              themeModel.changeThemeMode(ThemeMode.dark);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('常亮模式'),
            onPressed: () {
              themeModel.changeThemeMode(ThemeMode.light);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
