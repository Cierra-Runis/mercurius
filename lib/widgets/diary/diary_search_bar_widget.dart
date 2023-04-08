import 'package:mercurius/index.dart';

class DiarySearchBarWidget extends StatefulWidget {
  const DiarySearchBarWidget({super.key});

  @override
  State<DiarySearchBarWidget> createState() => _DiarySearchBarWidgetState();
}

class _DiarySearchBarWidgetState extends State<DiarySearchBarWidget> {
  @override
  void dispose() {
    diarySearchTextNotifier.contains = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        onChanged: (value) => diarySearchTextNotifier.changeContains(value),
        decoration: const InputDecoration(
          hintText: '查找日记内容',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
