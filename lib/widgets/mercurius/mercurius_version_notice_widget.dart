import 'package:mercurius/index.dart';

class MercuriusVersionNoticeWidget extends ConsumerWidget {
  const MercuriusVersionNoticeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final currentVersion = ref.watch(currentVersionProvider);
    final S localizations = S.of(context);

    return TextButton(
      onPressed: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const MercuriusReleasePage(),
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: githubLatestRelease.when(
          loading: () => false,
          error: (error, stackTrace) => false,
          data: (github) => currentVersion.when(
            loading: () => false,
            error: (error, stackTrace) => false,
            data: (currentVersion) => currentVersion != github.tag_name,
          ),
        )
            ? Colors.red
            : Colors.green,
        padding: const EdgeInsets.all(1.5),
        minimumSize: const Size(20, 10),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Badge(
        showBadge: githubLatestRelease.when(
          loading: () => false,
          error: (error, stackTrace) => false,
          data: (github) => currentVersion.when(
            loading: () => false,
            error: (error, stackTrace) => false,
            data: (currentVersion) => currentVersion != github.tag_name,
          ),
        ),
        child: Text(
          githubLatestRelease.when(
            loading: () => false,
            error: (error, stackTrace) => false,
            data: (github) => currentVersion.when(
              loading: () => false,
              error: (error, stackTrace) => false,
              data: (currentVersion) => currentVersion != github.tag_name,
            ),
          )
              ? localizations.clickHereToUpgrade
              : localizations.alreadyTheLatestVersion,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}
