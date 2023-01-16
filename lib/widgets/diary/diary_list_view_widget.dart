import 'package:mercurius/index.dart';

class DiaryListViewWidget extends StatefulWidget {
  const DiaryListViewWidget({super.key});

  @override
  State<DiaryListViewWidget> createState() => _DiaryListViewWidgetState();
}

class _DiaryListViewWidgetState extends State<DiaryListViewWidget> {
  Widget _getDiaryListCards(List<Diary>? data) {
    List<Widget> diaryListCards = [];
    if (data == null || data.isEmpty) {
      return const Center(
        child: Text('无数据'),
      );
    }

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

    diaryListCards.add(
      Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: const Text('没有更多了'),
        ),
      ),
    );

    return Scrollbar(
      radius: const Radius.circular(2.0),
      child: ListView(children: diaryListCards.toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiarySearchTextModel>(
      builder: (context, diarySearchTextModel, child) {
        return StreamBuilder<List<Diary>>(
          stream: isarService
              .listenToDiariesContains(diarySearchTextModel.contains),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Diary>> snapshot,
          ) {
            if (snapshot.hasError) {
              return Center(child: Text('Steam 错误: ${snapshot.error}'));
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Icon(UniconsLine.data_sharing));
              case ConnectionState.waiting:
                return const Center(child: Text('读取中'));
              case ConnectionState.active:
                return _getDiaryListCards(snapshot.data);
              case ConnectionState.done:
                return const Center(child: Text('Stream 已关闭'));
            }
          },
        );
      },
    );
  }
}
