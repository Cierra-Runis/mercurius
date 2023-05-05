import 'package:mercurius/index.dart';

class DiaryListViewCardWidget extends StatelessWidget {
  const DiaryListViewCardWidget({
    required key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final dayWidget = Text(
      diary.createDateTime.format('dd', 'zh_CN'),
      style: const TextStyle(
        fontSize: 24,
        fontFamily: 'Saira',
      ),
    );
    final weekdayWidget = Text(
      diary.createDateTime.format('EEEE', 'zh_CN'),
      style: const TextStyle(
        fontSize: 10,
      ),
    );
    final latestEditTimeWidget = Text(
      diary.latestEditTime.format('HH:mm:ss', 'zh_CN'),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
    final createDateTimeWidget = Text(
      diary.titleString ?? diary.createDateTime.format('y-M-d', 'zh_CN'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
    final contentJsonStringWidget = Text(
      Document.fromJson(
        jsonDecode(diary.contentJsonString!),
      ).toPlainText().replaceAll(RegExp('\n'), ''),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
    final moodWidget = Icon(
      size: 18,
      DiaryConstance.moodMap[diary.mood] ?? DiaryConstance.moodMap['开心'],
    );
    final weatherWidget = Icon(
      size: 18,
      QWeatherIcon.getIconDataById(
        int.parse(diary.weather),
      ),
    );

    return Dismissible(
      key: key!,
      onDismissed: (_) => isarService.deleteDiaryById(diary.id!),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          bool? confirm = await showDialog<bool>(
            context: context,
            builder: (context) {
              return const MercuriusOriginalConfirmDialogWidget(
                itemName: '这篇日记',
              );
            },
          );
          return confirm == true;
        }
        return false;
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: InkWell(
          onTap: () async {
            MercuriusKit.vibration();
            await showDialog<void>(
              context: context,
              builder: (context) => DiaryPageViewWidget(
                diary: diary,
              ),
            );
          },
          borderRadius: BorderRadius.circular(24.0),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 18, child: Container()),
                Expanded(
                  flex: 40,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [dayWidget, weekdayWidget],
                  ),
                ),
                Expanded(
                  flex: 142,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      latestEditTimeWidget,
                      createDateTimeWidget,
                      contentJsonStringWidget,
                    ],
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [moodWidget, weatherWidget],
                  ),
                ),
                Expanded(flex: 9, child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
