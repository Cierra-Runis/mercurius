import 'package:mercurius/index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: Center(
        child: BasedListView(
          children: [
            const GeneralSettingsSection(),
            if (Platform.isAndroid) const AndroidSettingsSection(),
          ],
        ),
      ),
    );
  }
}
