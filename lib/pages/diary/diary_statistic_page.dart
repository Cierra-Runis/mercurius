import 'package:mercurius/index.dart';

class DiaryStatisticPage extends StatelessWidget {
  const DiaryStatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计数据'),
      ),
      body: ListView(
        children: const [
          DiaryMonthlyWordsWidget(),
        ],
      ),
    );
  }
}
