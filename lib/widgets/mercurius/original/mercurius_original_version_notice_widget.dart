import 'package:mercurius/index.dart';

class MercuriusOriginalVersionNoticeWidget extends ConsumerWidget {
  const MercuriusOriginalVersionNoticeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);

    return githubLatestRelease.when(
      loading: () => const MercuriusOriginalLoadingWidget(),
      error: (error, stackTrace) => Container(),
      data: (data) => Consumer<MercuriusProfileNotifier>(
        builder: (
          context,
          mercuriusWebNotifier,
          child,
        ) {
          return TextButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const MercuriusReleasePage(),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor:
                  mercuriusProfileNotifier.profile.currentVersion !=
                          data.tag_name
                      ? Colors.red
                      : Colors.green,
              padding: const EdgeInsets.all(1.5),
              minimumSize: const Size(20, 10),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Badge(
              showBadge: mercuriusProfileNotifier.profile.currentVersion !=
                  data.tag_name,
              child: Text(
                mercuriusProfileNotifier.profile.currentVersion != data.tag_name
                    ? '点此更新版本'
                    : '已是最新版本',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
