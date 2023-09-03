import 'package:mercurius/index.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statistics),
      ),
      body: const MercuriusListWidget(
        children: [
          MonthlyWordsStatisticWidget(),
        ],
      ),
    );
  }
}
