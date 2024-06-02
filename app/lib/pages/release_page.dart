import 'package:mercurius/index.dart';

class ReleasePage extends ConsumerWidget {
  const ReleasePage({super.key});
  VoidCallback _downloadRelease(GitHubLatestRelease data) {
    return () {
      try {
        if (Platform.isAndroid) {
          final asset = data.assets?.firstWhereOr(
            (e) => e.name.endsWith('.apk'),
          );
          if (asset != null) {
            launchUrlString(
              asset.browserDownloadUrl,
              mode: LaunchMode.externalApplication,
            );
          }
        }
        if (Platform.isWindows) {
          final asset = data.assets?.firstWhereOr(
            (e) => e.name.endsWith('.zip'),
          );
          if (asset != null) {
            launchUrlString(
              asset.browserDownloadUrl,
              mode: LaunchMode.externalApplication,
            );
          }
        }
      } catch (e) {
        App.printLog('launch browser_download_url failed: $e');
      }
    };
  }

  Widget getBodyByData(BuildContext context, GitHubLatestRelease data) {
    final l10n = context.l10n;

    if (data.body != null) {
      return Markdown(
        styleSheet: MarkdownStyleSheet(
          blockquoteDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: context.colorScheme.surface,
          ),
        ),
        data: data.body!,
        onTapLink: (text, href, title) {
          if (href != null) {
            try {
              launchUrlString(href, mode: LaunchMode.externalApplication);
            } catch (e) {
              App.printLog('launch $href failed: $e');
            }
          }
        },
      );
    }
    return Center(
      child: Text(l10n.releasePageOops),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gitHubLatestRelease = ref.watch(gitHubLatestReleaseProvider);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.releasePage,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: gitHubLatestRelease.when(
          skipLoadingOnRefresh: false,
          loading: () => const Loading(),
          error: (error, stackTrace) => const SizedBox(),
          data: (data) => getBodyByData(context, data),
        ),
      ),
      floatingActionButton: Wrap(
        spacing: 8,
        direction: Axis.vertical,
        children: [
          FloatingActionButton.small(
            heroTag: 'refresh',
            onPressed: () => ref.refresh(gitHubLatestReleaseProvider),
            child: const Icon(Icons.refresh_rounded),
          ),
          FloatingActionButton.small(
            heroTag: 'download',
            onPressed: gitHubLatestRelease.when(
              loading: () => null,
              error: (error, stackTrace) => null,
              data: _downloadRelease,
            ),
            child: const Icon(Icons.download_rounded),
          ),
        ],
      ),
    );
  }
}
