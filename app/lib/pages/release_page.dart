import 'package:mercurius/index.dart';

class ReleasePage extends ConsumerWidget {
  const ReleasePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final l10n = context.l10n;

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
          data: (data) => getBodyByData(context, data),
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

  Widget getBodyByData(BuildContext context, GitHubLatestRelease data) {
    final l10n = context.l10n;

    if (data.body != null) {
      return Markdown(
        styleSheet: MarkdownStyleSheet(
          code: TextStyle(
            fontFamily: App.fontCascadiaCodePL,
            backgroundColor: context.colorScheme.secondaryContainer,
          ),
          blockquoteDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: context.colorScheme.surface,
          ),
        ),
        data: data.body!,
        onTapLink: (text, href, title) {
          if (href != null) App.launchUrl(href);
        },
      );
    }
    return Center(
      child: Text(l10n.releasePageOops),
    );
  }

  VoidCallback _downloadRelease(GitHubLatestRelease data) {
    return () {
      if (Platform.isAndroid) {
        final asset = data.assets?.firstWhereOr(
          (e) => e.name.endsWith('.apk'),
        );
        if (asset != null) {
          App.launchUrl(asset.browserDownloadUrl);
        }
      }
      if (Platform.isWindows) {
        final asset = data.assets?.firstWhereOr(
          (e) => e.name.endsWith('.zip'),
        );
        if (asset != null) {
          App.launchUrl(asset.browserDownloadUrl);
        }
      }
    };
  }
}
