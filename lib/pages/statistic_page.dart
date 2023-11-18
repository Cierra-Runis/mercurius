import 'package:mercurius/index.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.current;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statistics),
      ),
      body: const BasedListView(
        children: [
          MonthlyWords(),
        ],
      ),
    );
  }
}
