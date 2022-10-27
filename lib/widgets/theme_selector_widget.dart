import 'package:mercurius/common/index.dart';

import 'index.dart';

class ThemeSelectorWidget extends StatefulWidget {
  const ThemeSelectorWidget({super.key});

  @override
  State<ThemeSelectorWidget> createState() => _ThemeSelectorWidgetState();
}

class _ThemeSelectorWidgetState extends State<ThemeSelectorWidget> {
  @override
  Widget build(BuildContext context) {
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
            Global.profile.themeMode = ThemeMode.system;
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('常暗模式'),
          onPressed: () {
            Global.profile.themeMode = ThemeMode.dark;
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('常亮模式'),
          onPressed: () {
            Global.profile.themeMode = ThemeMode.light;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
