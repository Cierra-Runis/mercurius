import 'package:mercurius/index.dart';

class MercuriusVersionNoticeWidget extends ConsumerWidget {
  const MercuriusVersionNoticeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

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
          data: (github) => mercuriusProfile.when(
            loading: () => false,
            error: (error, stackTrace) => false,
            data: (profile) => profile.currentVersion != github.tag_name,
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
          data: (github) => mercuriusProfile.when(
            loading: () => false,
            error: (error, stackTrace) => false,
            data: (profile) => profile.currentVersion != github.tag_name,
          ),
        ),
        child: Text(
          githubLatestRelease.when(
            loading: () => false,
            error: (error, stackTrace) => false,
            data: (github) => mercuriusProfile.when(
              loading: () => false,
              error: (error, stackTrace) => false,
              data: (profile) => profile.currentVersion != github.tag_name,
            ),
          )
              ? '点此更新版本'
              : '已是最新版本',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}
