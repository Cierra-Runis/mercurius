import 'package:mercurius/index.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statistics),
      ),
      body: BasedListView(
        children: [
          BasedListSection(
            titleText: l10n.monthlyWordCountStatistics,
            titleTextStyle: const TextStyle(
              fontFamily: App.fontSaira,
              fontSize: 18,
            ),
            children: const [
              MonthlyWords(),
            ],
          ),
        ],
      ),
    );
  }
}
