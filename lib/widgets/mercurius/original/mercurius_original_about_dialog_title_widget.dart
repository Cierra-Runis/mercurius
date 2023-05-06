import 'package:mercurius/index.dart';

class MercuriusOriginalAboutDialogTitleWidget extends StatelessWidget {
  const MercuriusOriginalAboutDialogTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          MercuriusConstance.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Saira',
          ),
        ),
        Consumer<MercuriusProfileNotifier>(
          builder: (context, mercuriusProfileNotifier, child) {
            return Row(
              children: [
                Text(
                  '${mercuriusProfileNotifier.profile.currentVersion}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Saira',
                  ),
                ),
                const Padding(padding: EdgeInsets.all(2)),
                const MercuriusOriginalVersionNoticeWidget(),
              ],
            );
          },
        ),
      ],
    );
  }
}
