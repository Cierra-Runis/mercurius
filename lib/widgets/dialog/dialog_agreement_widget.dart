import 'package:mercurius/index.dart';

class DialogAgreementWidget extends StatelessWidget {
  const DialogAgreementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MercuriusOriginalJsonToDialogWidget(
      jsonPath: 'assets/json/agreement.json',
    );
  }
}
