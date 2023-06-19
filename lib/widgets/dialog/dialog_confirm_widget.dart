import 'package:mercurius/index.dart';

class MercuriusConfirmDialogWidget extends StatelessWidget {
  const MercuriusConfirmDialogWidget({
    super.key,
    required this.title,
    required this.summary,
    this.falseString,
    this.trueString,
    required this.context,
  });

  final String title;
  final String summary;
  final String? falseString;
  final String? trueString;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            summary,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(falseString ?? localizations.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(trueString ?? localizations.confirm),
        )
      ],
    );
  }

  Future<bool?> get confirm async {
    return await showDialog<bool?>(context: context, builder: (_) => this);
  }
}
