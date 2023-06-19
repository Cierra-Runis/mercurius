import 'package:mercurius/index.dart';

class DialogAboutWidget extends StatelessWidget {
  const DialogAboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MercuriusAppIconWidget(),
          DialogAboutTitleWidget(),
        ],
      ),
      content: const SizedBox(
        width: double.minPositive,
        child: DialogAboutContentWidget(),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(localizations.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
}
