import 'package:mercurius/index.dart';

class DialogAboutTitleWidget extends ConsumerWidget {
  const DialogAboutTitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);

    return Column(
      children: [
        const Text(
          MercuriusConstance.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Saira',
          ),
        ),
        Row(
          children: [
            Text(
              mercuriusProfile.when(
                loading: () => '未知版本',
                error: (error, stackTrace) => '版本获取失败',
                data: (profile) => '${profile.currentVersion}',
              ),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'Saira',
              ),
            ),
            const Padding(padding: EdgeInsets.all(2)),
            const MercuriusVersionNoticeWidget(),
          ],
        )
      ],
    );
  }
}
