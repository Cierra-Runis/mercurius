import 'package:mercurius/index.dart';

class MercuriusJsonToDialogWidget extends StatelessWidget {
  const MercuriusJsonToDialogWidget({
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

          return AlertDialog(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${Mercurius.name} $title'),
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
                onTapLink: (text, href, title) {
                  if (href != null) {
                    launchUrlString(
                      href,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                },
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
        return const MercuriusLoadingWidget();
      },
    );
  }

  /// FIXME: 不再读取本地 json，而是读取国际化数据
  Future<String> _loadAsset() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return rootBundle.loadString(jsonPath);
  }
}
