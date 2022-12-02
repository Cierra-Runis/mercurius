import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

Map<int, String> _weekdayMap = {
  1: '星期一',
  2: '星期二',
  3: '星期三',
  4: '星期四',
  5: '星期五',
  6: '星期六',
  7: '星期日',
};

Map<String, IconData> _moodMap = {
  '开心': UniconsLine.smile,
  '一般': UniconsLine.meh_closed_eye,
  '生气': UniconsLine.angry,
  '困惑': UniconsLine.confused,
  '失落': UniconsLine.frown,
  '大笑': UniconsLine.laughing,
  '难受': UniconsLine.silent_squint,
  '大哭': UniconsLine.sad_crying,
  '我死': UniconsLine.smile_dizzy,
};

class DiaryListCardWidget extends StatefulWidget {
  const DiaryListCardWidget({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  State<DiaryListCardWidget> createState() => _DiaryListCardWidgetState();
}

class _DiaryListCardWidgetState extends State<DiaryListCardWidget> {
  final isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          DevTools.printLog('[053] 进入修改模式');
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiaryEditorPage(diary: widget.diary),
            ),
          );
        },
        onLongPress: () {},
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 76,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 290,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.diary.createDateTime.substring(8, 10),
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Saira',
                          ),
                        ),
                        Text(
                          _weekdayMap[
                              DateTime.parse(widget.diary.createDateTime)
                                  .weekday]!,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 240,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.diary.latestEditTime.substring(11, 19),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.diary.titleString ??
                                widget.diary.latestEditTime.substring(0, 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            flutter_quill.Document.fromJson(
                              jsonDecode(widget.diary.contentJsonString!),
                            ).toPlainText(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(size: 18, _moodMap[widget.diary.mood] ?? _moodMap['开心']),
                  Icon(
                    size: 18,
                    QWeatherIcon.getIconById(
                      int.parse(widget.diary.weather),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
