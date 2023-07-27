import 'package:mercurius/index.dart';

class MercuriusReleasePage extends ConsumerWidget {
  const MercuriusReleasePage({super.key});

  VoidCallback _downloadRelease(GithubLatestRelease data) {
    return () {
      try {
        if (Platform.isAndroid) {
          GithubLatestReleaseAsset asset = data.assets!.firstWhere(
            (element) => element.name!.endsWith('.apk'),
          );
          launchUrlString(
            asset.browser_download_url!,
            mode: LaunchMode.externalApplication,
          );
        }
        if (Platform.isWindows) {
          GithubLatestReleaseAsset asset = data.assets!.firstWhere(
            (element) => element.name!.endsWith('.zip'),
          );
          launchUrlString(
            asset.browser_download_url!,
            mode: LaunchMode.externalApplication,
          );
        }
      } catch (e) {
        Mercurius.printLog(
          'launch browser_download_url failed: $e',
        );
      }
    };
  }

  Widget _getBodyByData(BuildContext context, GithubLatestRelease data) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    if (data.body != null) {
      return Markdown(
        styleSheet: MarkdownStyleSheet(
          blockquoteDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        data: data.body!,
        onTapLink: (text, href, title) {
          if (href != null) {
            try {
              launchUrlString(href, mode: LaunchMode.externalApplication);
            } catch (e) {
              Mercurius.printLog('launch $href failed: $e');
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
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          l10n.releasePage,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: githubLatestRelease.when(
          skipLoadingOnRefresh: false,
          loading: () => const MercuriusLoadingWidget(),
          error: (error, stackTrace) => Container(),
          data: (data) => _getBodyByData(context, data),
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
              data: _downloadRelease,
            ),
            mini: true,
            child: const Icon(Icons.download_rounded),
          ),
        ],
      ),
    );
  }
}
