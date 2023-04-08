import 'package:mercurius/index.dart';

import 'package:flutter_quill/flutter_quill.dart' as flutter_quill;

class DiaryMonthlyWordsWidget extends StatefulWidget {
  const DiaryMonthlyWordsWidget({super.key});

  @override
  State<DiaryMonthlyWordsWidget> createState() =>
      _DiaryMonthlyWordsWidgetState();
}

class _DiaryMonthlyWordsWidgetState extends State<DiaryMonthlyWordsWidget> {
  TooltipBehavior? _tooltipBehavior;
  ZoomPanBehavior? _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(
      header: '',
      format: 'point.x point.y 字',
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
    return SizedBox(
      height: 220,
      child: FutureBuilder<List<_DiaryWordsData>>(
        future: _getDiaryWordsData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfCartesianChart(
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
              title: ChartTitle(
                text: '月度字数统计',
                textStyle: const TextStyle(
                  fontFamily: 'Saira',
                  fontSize: 10,
                ),
              ),
              tooltipBehavior: _tooltipBehavior,
              zoomPanBehavior: _zoomPanBehavior,
              series: <ColumnSeries<_DiaryWordsData, String>>[
                ColumnSeries<_DiaryWordsData, String>(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  dataSource: snapshot.data!,
                  xValueMapper: (_DiaryWordsData sales, _) =>
                      sales.dateTime.toString().substring(0, 7),
                  yValueMapper: (_DiaryWordsData sales, _) => sales.sales,
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
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 20),
                const Text('月度字数统计中'),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<List<_DiaryWordsData>> _getDiaryWordsData() async {
    List<_DiaryWordsData> result = [];

    Map<DateTime, int> data = {};

    await Future.delayed(const Duration(milliseconds: 1000), () {});

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
      for (var element in diaries) {
        if (key.isSameYear(element.createDateTime) &&
            key.isSameMonth(element.createDateTime)) {
          data.update(
            key,
            (value) => value += flutter_quill.Document.fromJson(
              jsonDecode(element.contentJsonString!),
            ).toPlainText().replaceAll(RegExp(r'\n'), '').length,
          );
        }
      }
    });

    data.forEach((key, value) => result.add(_DiaryWordsData(key, value)));

    return result;
  }
}

class _DiaryWordsData {
  _DiaryWordsData(this.dateTime, this.sales);
  final DateTime dateTime;
  int sales;
}
