import 'package:mercurius/index.dart';

class DialogDeclarationWidget extends StatelessWidget {
  const DialogDeclarationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MercuriusOriginalJsonToDialogWidget(
      jsonPath: 'assets/json/declaration.json',
      onTapLink: (text, link, href, title) => _showDialogLicenseWidget(
        context,
        link[href],
      ),
    );
  }

  Future<void> _showDialogLicenseWidget(BuildContext context, String license) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  license,
                  style: const TextStyle(
                    fontFamily: 'Saira',
                    fontSize: 6,
                  ),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        );
      },
    );
  }
}
