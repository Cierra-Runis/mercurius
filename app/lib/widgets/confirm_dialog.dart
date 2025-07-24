import 'package:mercurius/index.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;

  final String summary;
  final String? denyString;
  final String? confirmString;
  final BuildContext context;
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.summary,
    this.denyString,
    this.confirmString,
    required this.context,
  });

  Future<ConfirmResult?> get confirm => context.pushDialog(this);

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
}

enum ConfirmResult { deny, confirm }
