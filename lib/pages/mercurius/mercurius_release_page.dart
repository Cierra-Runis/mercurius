import 'package:mercurius/index.dart';

class MercuriusReleasePage extends StatelessWidget {
  const MercuriusReleasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MercuriusWebNotifier>(
      builder: (context, mercuriusWebNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '更新至 ${mercuriusWebNotifier.githubLatestRelease.tag_name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: Markdown(
              data: mercuriusWebNotifier.githubLatestRelease.body ??
                  '# 啊啦\n\n你好像来到了奇怪的地方，要不回去先刷新一下？\n',
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showOptionMenu(context),
            mini: true,
            child: const Icon(Icons.download_rounded),
          ),
        );
      },
    );
  }

  Future<void> _showOptionMenu(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 115,
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(UniconsLine.github),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('从 Github 下载'),
                    Text(
                      '推荐源，但国内速度较慢',
                      style: TextStyle(
                        fontSize: 8,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => launchUrlString(
                  mercuriusWebNotifier
                      .githubLatestRelease.assets![0].browser_download_url!,
                  mode: LaunchMode.externalApplication,
                ),
              ),
              ListTile(
                leading: const Icon(UniconsLine.cloud),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('从 其他 下载'),
                    Text(
                      '其他源，暂未开放',
                      style: TextStyle(
                        fontSize: 8,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  /// TODO: 那样的其他源
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
