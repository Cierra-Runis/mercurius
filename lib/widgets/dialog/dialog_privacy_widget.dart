import 'package:mercurius/index.dart';

class DialogPrivacyWidget extends StatelessWidget {
  const DialogPrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mercurius 隐私政策'),
          Text(
            PrivacyContentConstance.privacyContentUpdateDate,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      content: const Markdown(
        shrinkWrap: true,
        data: PrivacyContentConstance.privacyContent,
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
