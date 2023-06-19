import 'package:mercurius/index.dart';

class DiaryStatisticPage extends StatelessWidget {
  const DiaryStatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.statistics),
      ),
      body: const MercuriusListWidget(
        children: [
          DiaryMonthlyWordsWidget(),
        ],
      ),
    );
  }
}
