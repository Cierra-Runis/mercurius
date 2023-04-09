import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryListCardWidget extends StatelessWidget {
  const DiaryListCardWidget({
    Key? key,
    required this.diary,
    required this.diaries,
    this.dayWidget,
    this.weekdayWidget,
    this.latestEditTimeWidget,
    this.createDateTimeWidget,
    this.contentJsonStringWidget,
    this.moodWidget,
    this.weatherWidget,
    this.enable = true,
  }) : super(key: key);

  final Diary diary;
  final List<Diary> diaries;

  final Widget? dayWidget;
  final Widget? weekdayWidget;
  final Widget? latestEditTimeWidget;
  final Widget? createDateTimeWidget;
  final Widget? contentJsonStringWidget;
  final Widget? moodWidget;
  final Widget? weatherWidget;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: InkWell(
        onTap: enable
            ? () async {
                MercuriusKit.vibration();
                _showDiaryPresentPageView(context, diary, diaries);
              }
            : null,
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          height: 76,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 18, child: Container()),
              Expanded(
                flex: 40,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dayWidget ??
                        Text(
                          diary.createDateTime.toString().substring(8, 10),
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'Saira',
                          ),
                        ),
                    weekdayWidget ??
                        Text(
                          DiaryConstance
                              .weekdayMap[diary.createDateTime!.weekday]!,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                  ],
                ),
              ),
              Expanded(
                flex: 142,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    latestEditTimeWidget ??
                        Text(
                          diary.latestEditTime.toString().substring(11, 19),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    createDateTimeWidget ??
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
                    contentJsonStringWidget ??
                        Text(
                          flutter_quill.Document.fromJson(
                            jsonDecode(diary.contentJsonString!),
                          ).toPlainText().replaceAll(RegExp('\n'), ''),
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
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    moodWidget ??
                        Icon(
                          size: 18,
                          DiaryConstance.moodMap[diary.mood] ??
                              DiaryConstance.moodMap['开心'],
                        ),
                    weatherWidget ??
                        Icon(
                          size: 18,
                          QWeatherIcon.getIconById(
                            int.parse(diary.weather),
                          ),
                        ),
                  ],
                ),
              ),
              Expanded(flex: 9, child: Container()),
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

  static DiaryListCardWidget getPlaceHolder(BuildContext context) {
    Color highlightColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.outline
        : Theme.of(context).colorScheme.outlineVariant;
    Color baseColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).colorScheme.outlineVariant
        : Theme.of(context).colorScheme.outline;

    return DiaryListCardWidget(
      diary: const Diary(),
      dayWidget: MercuriusFadeShimmerWidget(
        width: 24,
        height: 20,
        radius: 6,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      weatherWidget: MercuriusFadeShimmerWidget(
        width: 16,
        height: 16,
        radius: 8,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      weekdayWidget: MercuriusFadeShimmerWidget(
        width: 30,
        height: 10,
        radius: 5,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      moodWidget: MercuriusFadeShimmerWidget(
        width: 16,
        height: 16,
        radius: 8,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      createDateTimeWidget: MercuriusFadeShimmerWidget(
        width: 72,
        height: 16,
        radius: 8,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      latestEditTimeWidget: MercuriusFadeShimmerWidget(
        width: 32,
        height: 10,
        radius: 5,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      contentJsonStringWidget: MercuriusFadeShimmerWidget(
        width: 160,
        height: 12,
        radius: 6,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      diaries: const [],
      enable: false,
    );
  }
}
