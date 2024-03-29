import 'package:mercurius/index.dart';

class JsonToDialog extends StatelessWidget {
  const JsonToDialog({
    super.key,
    required this.title,
    required this.updateTime,
    required this.content,
    this.onTapLink,
  });

  final String title;
  final String updateTime;
  final String content;
  final void Function(
    String text,
    Map<String, dynamic> link,
    String? href,
    String title,
  )? onTapLink;

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${App.name} $title'),
          Text(
            updateTime,
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Markdown(
          shrinkWrap: true,
          softLineBreak: true,
          data: content,
          padding: const EdgeInsets.all(0),
          onTapLink: (text, href, title) {
            if (href != null) {
              try {
                launchUrlString(
                  href,
                  mode: LaunchMode.externalApplication,
                );
              } catch (e) {
                App.printLog('launch $href failed: $e');
              }
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(l10n.confirm),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
}
