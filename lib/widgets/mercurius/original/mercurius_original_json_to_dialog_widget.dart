import 'package:mercurius/index.dart';

class MercuriusOriginalJsonToDialogWidget extends StatelessWidget {
  const MercuriusOriginalJsonToDialogWidget({
    super.key,
    required this.jsonPath,
    this.onTapLink,
  });

  final String jsonPath;
  final void Function(
    String text,
    Map<String, dynamic> link,
    String? href,
    String title,
  )? onTapLink;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadAsset(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> map = jsonDecode(snapshot.data!);

          String title = map['title'];
          String updateDate = map['updateDate'];
          String content = map['content'];
          Map<String, dynamic> link = map['link'];

          return AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${MercuriusConstance.name} $title'),
                Text(
                  updateDate,
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
                data: content,
                padding: const EdgeInsets.all(0),
                onTapLink: onTapLink != null
                    ? (text, href, title) => onTapLink!(text, link, href, title)
                    : null,
              ),
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
        return const MercuriusOriginalLoadingWidget();
      },
    );
  }

  Future<String> _loadAsset() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return rootBundle.loadString(jsonPath);
  }
}
