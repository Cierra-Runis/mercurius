import 'package:mercurius/index.dart';

class MercuriusOriginalAppBarUserIconWidget extends ConsumerWidget {
  const MercuriusOriginalAppBarUserIconWidget({Key? key}) : super(key: key);

  void _appBarLeftButtonOnPressed(BuildContext context, Profile profile) {
    MercuriusKit.vibration();
    if (profile.user == null) {
      showDialog<void>(
        context: context,
        builder: (context) => const DialogLoginWidget(),
      );
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const MercuriusProfilePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);
    return IconButton(
      icon: const Icon(UniconsLine.user_circle),
      onPressed: mercuriusProfile.when(
        loading: () => null,
        error: (error, stackTrace) => null,
        data: (data) => () => _appBarLeftButtonOnPressed(context, data),
      ),
    );
  }
}
