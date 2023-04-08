import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryListCardWidget extends StatelessWidget {
  const DiaryListCardWidget({
    Key? key,
    required this.diary,
    required this.diaries,
  }) : super(key: key);

  final Diary diary;
  final List<Diary> diaries;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        onTap: () async {
          MercuriusKit.vibration();
          _showDiaryPresentPageView(context, diary, diaries);
        },
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          height: 76,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      diary.createDateTime.toString().substring(8, 10),
                      style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'Saira',
                      ),
                    ),
                    Text(
                      DiaryConstance.weekdayMap[diary.createDateTime.weekday]!,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 240,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      diary.latestEditTime.toString().substring(11, 19),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      diary.titleString ??
                          diary.createDateTime.toString().substring(0, 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      flutter_quill.Document.fromJson(
                        jsonDecode(diary.contentJsonString!),
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
              ),
              SizedBox(
                width: 24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      size: 18,
                      DiaryConstance.moodMap[diary.mood] ??
                          DiaryConstance.moodMap['开心'],
                    ),
                    Icon(
                      size: 18,
                      QWeatherIcon.getIconById(
                        int.parse(diary.weather),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDiaryPresentPageView(
    BuildContext context,
    Diary diary,
    List<Diary> diaries,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DiaryPresentPageView(
          diary: diary,
          diaries: diaries,
        );
      },
    );
  }
}
