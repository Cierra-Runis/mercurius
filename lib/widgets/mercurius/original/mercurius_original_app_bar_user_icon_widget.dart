import 'package:mercurius/index.dart';

class MercuriusOriginalAppBarUserIconWidget extends StatelessWidget {
  const MercuriusOriginalAppBarUserIconWidget({Key? key}) : super(key: key);

  void _appBarLeftButtonOnPressed(BuildContext context) {
    MercuriusKit.vibration();
    if (mercuriusProfileNotifier.profile.user == null) {
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
  Widget build(BuildContext context) {
    return Consumer<MercuriusProfileNotifier>(
      builder: (context, value, child) => IconButton(
        icon: const Icon(UniconsLine.user_circle),
        onPressed: () => _appBarLeftButtonOnPressed(context),
      ),
    );
  }
}
