import 'package:mercurius/index.dart';

class DialogAboutWidget extends StatelessWidget {
  const DialogAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MercuriusOriginalAppIconWidget(),
          MercuriusOriginalAboutDialogTitleWidget(),
        ],
      ),
      content: const SizedBox(
        width: double.minPositive,
        child: MercuriusOriginalAboutDialogContentWidget(),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('返回'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
}
