import 'package:mercurius/index.dart';

class DialogAgreementWidget extends StatelessWidget {
  const DialogAgreementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mercurius 用户协议'),
          Text(
            AgreementContentConstance.agreementContentUpdateDate,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      content: const Markdown(
        shrinkWrap: true,
        data: AgreementContentConstance.agreementContent,
        padding: EdgeInsets.all(0),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('确认'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
}
