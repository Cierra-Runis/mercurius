import 'package:mercurius/index.dart';

class MonthlyWords extends HookWidget {
  const MonthlyWords({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).toLanguageTag();

    return SizedBox(
      height: 220,
      child: FutureBuilder<List<_WordsData>>(
        future: _getWordsData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Loading();

          return SfCartesianChart(
            margin: const EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 12.0),
            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              labelPlacement: LabelPlacement.onTicks,
              labelStyle: TextStyle(fontSize: 6),
            ),
            primaryYAxis: const NumericAxis(
              axisLine: AxisLine(width: 0),
              labelFormat: '{value}',
              majorTickLines: MajorTickLines(size: 0),
              labelStyle: TextStyle(fontSize: 6),
            ),
            tooltipBehavior: TooltipBehavior(
              header: '',
              format: 'point.x point.y',
              enable: true,
              textStyle: const TextStyle(fontSize: 8),
            ),
            zoomPanBehavior: ZoomPanBehavior(
              enablePinching: true,
              zoomMode: ZoomMode.x,
              enablePanning: true,
            ),
            series: <ColumnSeries<_WordsData, String>>[
              ColumnSeries<_WordsData, String>(
                color: context.colorScheme.primary.withOpacity(0.7),
                dataSource: snapshot.data!,
                xValueMapper: (data, _) =>
                    data.dateTime.format(DateFormat.YEAR_ABBR_MONTH, lang),
                yValueMapper: (sales, _) => sales.words,
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
        },
      ),
    );
  }

  Future<List<_WordsData>> _getWordsData() async {
    final result = <_WordsData>[];

    final data = <DateTime, int>{};

    await Future.delayed(const Duration(milliseconds: 1000));

    final diaries = await isarService.getAllDiaries();

    if (diaries.isEmpty) {
      return result;
    }

    var start = diaries.first.belongTo;
    start = DateTime(start.year, start.month);
    final end = diaries.last.belongTo;

    while (start.isBefore(end)) {
      data.addAll({start: 0});
      start = DateTime(start.year, start.month + 1);
    }

    data.forEach((key, _) {
      for (final diary in diaries) {
        if (key.isSameYear(diary.belongTo) && key.isSameMonth(diary.belongTo)) {
          data.update(key, (value) => value += diary.length);
        }
      }
    });

    data.forEach((key, value) => result.add(_WordsData(key, value)));

    return result;
  }
}

class _WordsData {
  _WordsData(this.dateTime, this.words);
  final DateTime dateTime;
  int words;
}
