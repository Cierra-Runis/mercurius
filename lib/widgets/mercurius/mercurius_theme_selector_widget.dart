import 'package:mercurius/index.dart';

class MercuriusThemeSelectorWidget extends ConsumerWidget {
  const MercuriusThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S localizations = S.of(context);

    return StreamBuilder(
        stream: isarService.listenToConfig(),
        builder: (context, snapshot) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.all(0),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(localizations.followTheSystem),
                onPressed: () async {
                  Navigator.of(context).pop();
                  isarService
                      .saveConfig(snapshot.data!..themeMode = ThemeMode.system);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(localizations.alwaysDark),
                onPressed: () async {
                  Navigator.of(context).pop();
                  isarService
                      .saveConfig(snapshot.data!..themeMode = ThemeMode.dark);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(localizations.alwaysBright),
                onPressed: () async {
                  Navigator.of(context).pop();
                  isarService
                      .saveConfig(snapshot.data!..themeMode = ThemeMode.light);
                },
              ),
            ],
          );
        });
  }
}
