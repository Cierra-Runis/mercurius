import 'package:mercurius/index.dart';

class MercuriusReleasePage extends ConsumerWidget {
  const MercuriusReleasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '更新页',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: githubLatestRelease.when(
          loading: () => const MercuriusOriginalLoadingWidget(),
          error: (error, stackTrace) => Container(),
          data: (data) => Markdown(
            data: data.body ?? '##### 啊啦\n\n你好像来到了奇怪的地方，要不回去先刷新一下？\n',
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
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => ref.refresh(githubLatestReleaseProvider),
            mini: true,
            child: const Icon(Icons.refresh_rounded),
          ),
          FloatingActionButton(
            onPressed: githubLatestRelease.when(
              loading: () => null,
              error: (error, stackTrace) => null,
              data: (data) => () => _showOptionMenu(context, data),
            ),
            mini: true,
            child: const Icon(Icons.download_rounded),
          ),
        ],
      ),
    );
  }

  Future<void> _showOptionMenu(
    BuildContext context,
    GithubLatestRelease githubLatestRelease,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return MercuriusModifiedList(
          shrinkWrap: true,
          children: [
            MercuriusModifiedListSection(
              children: [
                MercuriusModifiedListItem(
                  iconData: UniconsLine.github,
                  titleText: '从 Github 下载',
                  summaryText: '推荐源，但国内速度较慢',
                  onTap: () => launchUrlString(
                    githubLatestRelease.assets![0].browser_download_url!,
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                MercuriusModifiedListItem(
                  iconData: UniconsLine.cloud,
                  titleText: '从 其他 下载',
                  summaryText: '其他源，暂未开放',
                  onTap: () {
                    /// TODO: 那样的其他源
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
