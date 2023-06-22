import 'package:mercurius/index.dart';

class MercuriusReleasePage extends ConsumerWidget {
  const MercuriusReleasePage({super.key});

  Widget getBodyByData(BuildContext context, GithubLatestRelease data) {
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
            launchUrlString(href, mode: LaunchMode.externalApplication);
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: githubLatestRelease.when(
          skipLoadingOnRefresh: false,
          loading: () => const MercuriusLoadingWidget(),
          error: (error, stackTrace) => Container(),
          data: (data) => getBodyByData(context, data),
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
              data: (data) {
                if (data.assets != null) {
                  return () {
                    launchUrlString(
                      data.assets![0].browser_download_url!,
                      mode: LaunchMode.externalApplication,
                    );
                  };
                } else {
                  return null;
                }
              },
            ),
            mini: true,
            child: const Icon(Icons.download_rounded),
          ),
        ],
      ),
    );
  }
}
