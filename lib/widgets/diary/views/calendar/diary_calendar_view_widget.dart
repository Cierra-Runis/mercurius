import 'package:mercurius/index.dart';

class DiaryCalendarViewWidget extends StatelessWidget {
  const DiaryCalendarViewWidget({super.key});

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
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          shape: BoxShape.circle,
        ),
      ),
      locale: 'zh_CN',
    );
  }
}
