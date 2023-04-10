import 'package:mercurius/index.dart';

class MercuriusOriginalVersionNoticeWidget extends StatelessWidget {
  const MercuriusOriginalVersionNoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MercuriusWebNotifier, MercuriusProfileNotifier>(
      builder:
          (context, mercuriusWebNotifier, mercuriusProfileNotifier, child) {
        return TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MercuriusReleasePage(),
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: mercuriusProfileNotifier.profile.currentVersion !=
                    mercuriusWebNotifier.githubLatestRelease.tag_name
                ? Colors.red
                : Colors.green,
            padding: const EdgeInsets.all(1.5),
            minimumSize: const Size(20, 10),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Badge(
            showBadge: mercuriusProfileNotifier.profile.currentVersion !=
                mercuriusWebNotifier.githubLatestRelease.tag_name,
            child: Text(
              mercuriusProfileNotifier.profile.currentVersion !=
                      mercuriusWebNotifier.githubLatestRelease.tag_name
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
    );
  }
}
