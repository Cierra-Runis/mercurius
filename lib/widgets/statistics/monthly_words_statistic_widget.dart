import 'package:mercurius/index.dart';

class MonthlyWordsStatisticWidget extends ConsumerStatefulWidget {
  const MonthlyWordsStatisticWidget({super.key});

  @override
  ConsumerState<MonthlyWordsStatisticWidget> createState() =>
      _DiaryMonthlyWordsWidgetState();
}

class _DiaryMonthlyWordsWidgetState
    extends ConsumerState<MonthlyWordsStatisticWidget> {
  TooltipBehavior? _tooltipBehavior;
  ZoomPanBehavior? _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      header: '',
      format: 'point.x point.y',
      enable: true,
      textStyle: const TextStyle(
        fontFamily: 'Saira',
        fontSize: 8,
      ),
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);
    final String lang = Localizations.localeOf(context).toLanguageTag();

    return BasedListSection(
      titleText: l10n.monthlyWordCountStatistics,
      titleTextStyle: const TextStyle(
        fontFamily: 'Saira',
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
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    labelPlacement: LabelPlacement.onTicks,
                    labelStyle: const TextStyle(
                      fontFamily: 'Saira',
                      fontSize: 6,
                    ),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    labelFormat: '{value}',
                    majorTickLines: const MajorTickLines(size: 0),
                    labelStyle: const TextStyle(
                      fontFamily: 'Saira',
                      fontSize: 6,
                    ),
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  zoomPanBehavior: _zoomPanBehavior,
                  series: <ColumnSeries<_DiaryWordsData, String>>[
                    ColumnSeries<_DiaryWordsData, String>(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      dataSource: snapshot.data!,
                      xValueMapper: (_DiaryWordsData data, _) => data.dateTime
                          .format(DateFormat.YEAR_ABBR_MONTH, lang),
                      yValueMapper: (_DiaryWordsData sales, _) => sales.words,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(
                          fontFamily: 'Saira',
                          fontSize: 6,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const MercuriusLoadingWidget();
            },
          ),
        ),
      ],
    );
  }

  Future<List<_DiaryWordsData>> _getDiaryWordsData(WidgetRef ref) async {
    List<_DiaryWordsData> result = [];

    Map<DateTime, int> data = {};

    await Future.delayed(const Duration(milliseconds: 1000));

    List<Diary> diaries = await isarService.getAllDiaries();

    if (diaries.isEmpty) {
      return result;
    }

    DateTime start = diaries[0].createDateTime;
    start = DateTime(start.year, start.month, 1);
    DateTime end = diaries[diaries.length - 1].createDateTime;

    while (start.isBefore(end)) {
      data.addAll({start: 0});
      start = DateTime(start.year, start.month + 1);
    }

    data.forEach((key, _) {
      for (Diary diary in diaries) {
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
