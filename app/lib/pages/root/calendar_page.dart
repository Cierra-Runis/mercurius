import 'package:mercurius/index.dart';

import '_app_bar_title.dart';
import '_search_button.dart';

class CalendarPage extends HookWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final offset = useState(0);

    return Scaffold(
      appBar: AppBar(
        leading: const SearchButton(),
        title: const AppBarTitle(),
        actions: [
          _Previous(controller: offset),
          _Next(controller: offset),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Durations.medium2,
        child: _Month(
          key: ValueKey(offset.value),
          dateTime: DateTimeExtension.today.addMonths(offset.value),
        ),
      ),
    );
  }
}

class _Day extends StatelessWidget {
  final List<Diary> diaries;

  final DateTime dateTime;
  const _Day({
    super.key,
    required this.diaries,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Badge(
        isLabelVisible: diaries.isNotEmpty,
        label: diaries.length > 1 ? Text('${diaries.length}') : null,
        child: IconButton(
          onPressed: () {
            if (diaries.isEmpty) return;
            // context.push(DiaryPageView(initialId: diaries.first.id));
          },
          icon: Text('${dateTime.day}'),
        ),
      ),
    );
  }
}

class _Month extends HookWidget {
  final DateTime dateTime;

  const _Month({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final ml10n = context.ml10n;
    final languageTag = context.languageTag;
    final startOfMonth = dateTime.startOfMonth;
    final endOfMonth = dateTime.endOfMonth;
    final needSkipCount = DateUtils.firstDayOffset(
      dateTime.year,
      dateTime.month,
      ml10n,
    );

    // final stream = useMemoized(
    //   () => isarService.listenDiariesBetween(
    //     startOfMonth,
    //     endOfMonth.subSeconds(1),
    //   ),
    // );

    // final snapshot = useStream(stream);
    // final monthDiaries = snapshot.data ?? [];

    final itemCount = DateTime.daysPerWeek +
        needSkipCount +
        DateUtils.getDaysInMonth(dateTime.year, dateTime.month);

    return Scaffold(
      appBar: AppBar(
        title: Text(dateTime.format(DateFormat.YEAR_MONTH, languageTag)),
        centerTitle: false,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: DateTime.daysPerWeek,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final isTitle = index < DateTime.daysPerWeek;
          if (isTitle) {
            final title = ml10n.narrowWeekdays[index];
            return Center(child: Text(title));
          }

          final needSkip = index < DateTime.daysPerWeek + needSkipCount;
          if (needSkip) return const SizedBox.shrink();

          final offset = index - DateTime.daysPerWeek - needSkipCount;
          final dateTime = startOfMonth.addDays(offset);
          // final diaries = monthDiaries
          //     .where((e) => dateTime.isSameDay(e.belongTo))
          //     .toList();

          return _Day(
            key: Key('$offset'),
            // diaries: diaries,
            diaries: [],
            dateTime: dateTime,
          );
        },
      ),
    );
  }
}

class _Next extends StatelessWidget {
  final ValueNotifier<int> controller;

  const _Next({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => controller.value += 1,
      icon: const Icon(Icons.navigate_next_rounded),
    );
  }
}

class _Previous extends StatelessWidget {
  final ValueNotifier<int> controller;

  const _Previous({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => controller.value -= 1,
      icon: const Icon(Icons.navigate_before_rounded),
    );
  }
}
