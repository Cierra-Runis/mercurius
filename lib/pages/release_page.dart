import 'package:mercurius/index.dart';

class ReleasePage extends ConsumerWidget {
  const ReleasePage({super.key});

  VoidCallback _downloadRelease(GithubLatestRelease data) {
    return () {
      try {
        if (Platform.isAndroid) {
          final asset = data.assets!.firstWhere(
            (element) => element.name!.endsWith('.apk'),
          );
          launchUrlString(
            asset.browser_download_url!,
            mode: LaunchMode.externalApplication,
          );
        }
        if (Platform.isWindows) {
          final asset = data.assets!.firstWhere(
            (element) => element.name!.endsWith('.zip'),
          );
          launchUrlString(
            asset.browser_download_url!,
            mode: LaunchMode.externalApplication,
          );
        }
      } catch (e) {
        App.printLog('launch browser_download_url failed: $e');
      }
    };
  }

  Widget _getBodyByData(BuildContext context, GithubLatestRelease data) {
    final l10n = L10N.current;

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
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final l10n = L10N.current;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.releasePage,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: githubLatestRelease.when(
          skipLoadingOnRefresh: false,
          loading: () => const Loading(),
          error: (error, stackTrace) => const SizedBox(),
          data: (data) => _getBodyByData(context, data),
        ),
      ),
      floatingActionButton: Wrap(
        spacing: 8,
        direction: Axis.vertical,
        children: [
          FloatingActionButton.small(
            heroTag: 'refresh',
            onPressed: () => ref.refresh(githubLatestReleaseProvider),
            child: const Icon(Icons.refresh_rounded),
          ),
          FloatingActionButton.small(
            heroTag: 'download',
            onPressed: githubLatestRelease.when(
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
