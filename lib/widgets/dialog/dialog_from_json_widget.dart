import 'package:mercurius/index.dart';

class MercuriusJsonToDialogWidget extends StatelessWidget {
  const MercuriusJsonToDialogWidget({
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
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${Mercurius.name} $title'),
          Text(
            updateTime,
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
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
                Mercurius.printLog('launch $href failed: $e');
              }
            }
          },
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(l10n.confirm),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
    );
  }
}
