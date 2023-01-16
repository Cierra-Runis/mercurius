import 'package:mercurius/index.dart';

class DiaryCalendarViewWidget extends StatefulWidget {
  const DiaryCalendarViewWidget({super.key});

  @override
  State<DiaryCalendarViewWidget> createState() =>
      _DiaryCalendarViewWidgetState();
}

class _DiaryCalendarViewWidgetState extends State<DiaryCalendarViewWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(1949, 10, 1),
      lastDay: DateTime.now().add(const Duration(days: 20000)),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontFamily: 'Saira',
        ),
        leftChevronIcon: Icon(UniconsLine.angle_double_left),
        rightChevronIcon: Icon(UniconsLine.angle_double_right),
      ),
      locale: 'zh_CN',
    );
  }
}
