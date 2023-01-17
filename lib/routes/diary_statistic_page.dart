import 'package:mercurius/index.dart';

class DiaryStatisticPage extends StatefulWidget {
  const DiaryStatisticPage({super.key});

  @override
  State<DiaryStatisticPage> createState() => _DiaryStatisticPageState();
}

class _DiaryStatisticPageState extends State<DiaryStatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('统计数据'),
      ),
      body: const PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              DiaryMonthlyWordsWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
