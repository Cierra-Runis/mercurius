import 'package:mercurius/index.dart';

class DialogAboutTitleWidget extends ConsumerWidget {
  const DialogAboutTitleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentVersion = ref.watch(currentVersionProvider);
    final MercuriusL10N l10n = MercuriusL10N.of(context);

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
                loading: () => l10n.unknownVersion,
                error: (error, stackTrace) => l10n.failedToGetVersion,
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
