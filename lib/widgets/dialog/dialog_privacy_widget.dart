import 'package:mercurius/index.dart';

class DialogPrivacyWidget extends StatelessWidget {
  const DialogPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MercuriusOriginalJsonToDialogWidget(
      jsonPath: 'assets/json/privacy.json',
    );
  }
}
