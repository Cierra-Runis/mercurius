import '../../../app/lib/index.dart';

class MonthlyWords extends ConsumerWidget {
  const MonthlyWords({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;
    final lang = Localizations.localeOf(context).toLanguageTag();

    return BasedListSection(
      titleText: l10n.monthlyWordCountStatistics,
      titleTextStyle: const TextStyle(
        fontFamily: App.fontSaira,
        fontSize: 18,
      ),
      children: [
        SizedBox(
          height: 220,
          child: FutureBuilder<List<_DiaryWordsData>>(
            future: _getDiaryWordsData(ref),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SfCartesianChart(
                  margin: const EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 12.0),
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    labelPlacement: LabelPlacement.onTicks,
                    labelStyle: TextStyle(
                      fontFamily: App.fontSaira,
                      fontSize: 6,
                    ),
                  ),
                  primaryYAxis: const NumericAxis(
                    axisLine: AxisLine(width: 0),
                    labelFormat: '{value}',
                    majorTickLines: MajorTickLines(size: 0),
                    labelStyle: TextStyle(
                      fontFamily: App.fontSaira,
                      fontSize: 6,
                    ),
                  ),
                  tooltipBehavior: TooltipBehavior(
                    header: '',
                    format: 'point.x point.y',
                    enable: true,
                    textStyle: const TextStyle(
                      fontFamily: App.fontSaira,
                      fontSize: 8,
                    ),
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    zoomMode: ZoomMode.x,
                    enablePanning: true,
                  ),
                  series: <ColumnSeries<_DiaryWordsData, String>>[
                    ColumnSeries<_DiaryWordsData, String>(
                      color: context.colorScheme.primary.withOpacity(0.7),
                      dataSource: snapshot.data!,
                      xValueMapper: (_DiaryWordsData data, _) => data.dateTime
                          .format(DateFormat.YEAR_ABBR_MONTH, lang),
                      yValueMapper: (_DiaryWordsData sales, _) => sales.words,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          fontFamily: App.fontSaira,
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Loading();
            },
          ),
        ),
      ],
    );
  }

  Future<List<_DiaryWordsData>> _getDiaryWordsData(WidgetRef ref) async {
    final result = <_DiaryWordsData>[];

    final data = <DateTime, int>{};

    await Future.delayed(const Duration(milliseconds: 1000));

    final diaries = await isarService.getAllDiaries();

    if (diaries.isEmpty) {
      return result;
    }

    var start = diaries[0].createDateTime;
    start = DateTime(start.year, start.month);
    final end = diaries[diaries.length - 1].createDateTime;

    while (start.isBefore(end)) {
      data.addAll({start: 0});
      start = DateTime(start.year, start.month + 1);
    }

    data.forEach((key, _) {
      for (final diary in diaries) {
        if (key.isSameYear(diary.createDateTime) &&
            key.isSameMonth(diary.createDateTime)) {
          data.update(key, (value) => value += diary.words);
        }
      }
    });

    data.forEach((key, value) => result.add(_DiaryWordsData(key, value)));

    return result;
  }
}

class _DiaryWordsData {
  _DiaryWordsData(this.dateTime, this.words);
  final DateTime dateTime;
  int words;
}
