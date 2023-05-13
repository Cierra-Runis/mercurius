import 'package:mercurius/index.dart';

class MercuriusThemeSelectorWidget extends ConsumerWidget {
  const MercuriusThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

    return mercuriusProfile.when(
      loading: () => const MercuriusLoadingWidget(),
      error: (error, stackTrace) => Container(),
      data: (profile) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.all(0),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('跟随系统'),
            onPressed: () {
              ref.watch(mercuriusProfileProvider.notifier).changeProfile(
                    profile..themeMode = ThemeMode.system,
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
              ref.watch(mercuriusProfileProvider.notifier).changeProfile(
                    profile..themeMode = ThemeMode.dark,
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
              ref.watch(mercuriusProfileProvider.notifier).changeProfile(
                    profile..themeMode = ThemeMode.light,
                  );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
