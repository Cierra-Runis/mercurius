import 'package:mercurius/index.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
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
    final l10n = L10N.maybeOf(context) ?? L10N.current;

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
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(falseString ?? l10n.cancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(trueString ?? l10n.confirm),
        ),
      ],
    );
  }

  Future<bool?> get confirm => context.pushDialog(this);
}
