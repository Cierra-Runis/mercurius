import 'package:mercurius/index.dart';

class DialogAboutTitleWidget extends ConsumerWidget {
  const DialogAboutTitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentVersion = ref.watch(currentVersionProvider);

    return Column(
      children: [
        const Text(
          Mercurius.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Saira',
          ),
        ),
        Row(
          children: [
            Text(
              currentVersion.when(
                loading: () => '未知版本',
                error: (error, stackTrace) => '版本获取失败',
                data: (data) => data,
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
