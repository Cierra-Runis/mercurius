import 'package:mercurius/index.dart';

class ImportDeclarationDialogWidget extends StatefulWidget {
  const ImportDeclarationDialogWidget({super.key});

  @override
  State<ImportDeclarationDialogWidget> createState() =>
      _ImportDeclarationDialogWidgetState();
}

class _ImportDeclarationDialogWidgetState
    extends State<ImportDeclarationDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mercurius 引入声明'),
          Text(
            DeclarationContentConstance.declarationContentUpdateDate,
            style: TextStyle(
              fontSize: 10,
              color: (Theme.of(context).brightness == Brightness.dark)
                  ? Colors.white54
                  : Colors.black54,
            ),
          ),
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          Markdown(
            shrinkWrap: true,
            data: DeclarationContentConstance.declarationContent,
            padding: const EdgeInsets.all(0),
            onTapLink: (text, href, title) => _licenseDialog(
              context,
              DeclarationContentConstance.license[href],
            ),
          ),
        ],
      ),
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

  Future<void> _licenseDialog(BuildContext context, String license) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: ListView(
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
