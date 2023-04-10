import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryListViewCardWidget extends StatelessWidget {
  const DiaryListViewCardWidget({
    Key? key,
    required this.diary,
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
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: InkWell(
        onTap: enable
            ? () async {
                MercuriusKit.vibration();
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => DiaryPageViewWidget(
                    diary: diary,
                  ),
                );
              }
            : null,
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

  factory DiaryListViewCardWidget.getPlaceHolder(BuildContext context) {
    Color highlightColor =
        Theme.of(context).colorScheme.outline.withOpacity(0.38);
    Color baseColor = Theme.of(context).colorScheme.surface;

    return DiaryListViewCardWidget(
      diary: const Diary(),
      dayWidget: MercuriusModifiedFadeShimmerWidget(
        width: 24,
        height: 20,
        radius: 6,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      weatherWidget: MercuriusModifiedFadeShimmerWidget.round(
        size: 16,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      weekdayWidget: MercuriusModifiedFadeShimmerWidget(
        width: 30,
        height: 10,
        radius: 5,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      moodWidget: MercuriusModifiedFadeShimmerWidget.round(
        size: 16,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      createDateTimeWidget: MercuriusModifiedFadeShimmerWidget(
        width: 72,
        height: 16,
        radius: 8,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      latestEditTimeWidget: MercuriusModifiedFadeShimmerWidget(
        width: 32,
        height: 10,
        radius: 5,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      contentJsonStringWidget: MercuriusModifiedFadeShimmerWidget(
        width: 160,
        height: 12,
        radius: 6,
        highlightColor: highlightColor,
        baseColor: baseColor,
      ),
      enable: false,
    );
  }
}
