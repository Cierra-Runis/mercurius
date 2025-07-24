import 'package:mercurius/index.dart';

class MonthlyWords extends HookWidget {
  const MonthlyWords({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.languageTag;

    return SizedBox(
      height: 260,
      child: SfCartesianChart(
        margin: const EdgeInsets.fromLTRB(12.0, 24.0, 24.0, 12.0),
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks,
          labelStyle: TextStyle(fontSize: App.fontSize6),
        ),
        primaryYAxis: const NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0),
          labelStyle: TextStyle(fontSize: App.fontSize6),
        ),
        tooltipBehavior: TooltipBehavior(
          header: '',
          format: 'point.x point.y',
          enable: true,
          textStyle: const TextStyle(fontSize: App.fontSize8),
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          zoomMode: ZoomMode.x,
          enablePanning: true,
        ),
        series: <ColumnSeries<_WordsData, String>>[
          ColumnSeries<_WordsData, String>(
            color: context.colorScheme.primary.withValues(alpha: 0.7),
            // dataSource: _getWordsData(data),
            xValueMapper: (data, _) =>
                data.dateTime.format(DateFormat.YEAR_ABBR_MONTH, lang),
            yValueMapper: (sales, _) => sales.words,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(
                fontFamily: App.fontCascadiaCodePL,
                fontSize: App.fontSize6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WordsData {
  final DateTime dateTime;
  int words;
  _WordsData(this.dateTime, this.words);
}
