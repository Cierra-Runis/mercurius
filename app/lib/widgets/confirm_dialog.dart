import 'package:mercurius/index.dart';

enum ConfirmResult { deny, confirm }

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.summary,
    this.denyString,
    this.confirmString,
    required this.context,
  });

  final String title;
  final String summary;
  final String? denyString;
  final String? confirmString;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            summary,
            style: TextStyle(
              fontSize: App.fontSize10,
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(ConfirmResult.deny),
          child: Text(denyString ?? l10n.cancel),
        ),
        TextButton(
          onPressed: () => context.pop(ConfirmResult.confirm),
          child: Text(confirmString ?? l10n.confirm),
        ),
      ],
    );
  }

  Future<ConfirmResult?> get confirm => context.pushDialog(this);
}
