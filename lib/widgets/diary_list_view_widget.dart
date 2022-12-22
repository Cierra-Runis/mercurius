import 'package:mercurius/index.dart';

class DiaryListViewWidget extends StatefulWidget {
  const DiaryListViewWidget({super.key});

  @override
  State<DiaryListViewWidget> createState() => _DiaryListViewWidgetState();
}

class _DiaryListViewWidgetState extends State<DiaryListViewWidget> {
  final isarService = IsarService();

  Widget getDiaryListCards(List<Diary>? data) {
    List<Widget> diaryListCards = [];
    if (data == null || data.isEmpty) {
      return const Center(
        child: Text('无数据'),
      );
    }

    data = data.reversed.toList();

    int year = data[0].createDateTime.year;
    int month = data[0].createDateTime.month;
    diaryListCards.add(
      Container(
        margin: const EdgeInsets.fromLTRB(24, 10, 10, 0),
        child: Text(
          '$year年$month月',
          style: const TextStyle(
            fontSize: 20.0,
            fontFamily: 'Saira',
          ),
        ),
      ),
    );
    for (var element in data) {
      if (element.createDateTime.month != month ||
          element.createDateTime.year != year) {
        month = element.createDateTime.month;
        year = element.createDateTime.year;
        diaryListCards.add(
          Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 10, 0),
            child: Text(
              '$year年$month月',
              style: const TextStyle(
                fontSize: 20.0,
                fontFamily: 'Saira',
              ),
            ),
          ),
        );
      }
      diaryListCards.add(DiaryListCardWidget(diary: element));
    }

    ListView listView = ListView(
      controller: ScrollController(),
      children: diaryListCards.toList(),
    );

    return Scrollbar(
      radius: const Radius.circular(2.0),
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Diary>>(
      stream: isarService.listenToDiaries(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Diary>> snapshot,
      ) {
        if (snapshot.hasError) {
          return Text('Steam 错误: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center(
              child: Icon(UniconsLine.data_sharing),
            );
          case ConnectionState.waiting:
            return Container();
          case ConnectionState.active:
            return getDiaryListCards(snapshot.data);
          case ConnectionState.done:
            return const Text('Stream 已关闭');
        }
      },
    );
  }
}
