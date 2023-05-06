import 'package:mercurius/index.dart';

class MercuriusHomePage extends ConsumerStatefulWidget {
  const MercuriusHomePage({super.key});

  @override
  ConsumerState<MercuriusHomePage> createState() => _MercuriusHomePageState();
}

class _MercuriusHomePageState extends ConsumerState<MercuriusHomePage> {
  bool _currentListViewMode = true;
  bool _currentSearchBarMode = false;

  void _switchCurrentViewMode() {
    MercuriusKit.vibration();
    ref.watch(diarySearchTextProvider.notifier).change();

    setState(() {
      _currentListViewMode = !_currentListViewMode;
      _currentSearchBarMode = false;
    });
  }

  void _switchCurrentBarMode() {
    MercuriusKit.vibration();
    ref.watch(diarySearchTextProvider.notifier).change();

    setState(() {
      _currentSearchBarMode = !_currentSearchBarMode;
    });
  }

  void _floatingButtonOnPressed() async {
    MercuriusKit.vibration();

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(1949, 10, 1),
      lastDate: DateTime.now().add(
        const Duration(days: 20000),
      ),
    );

    if (context.mounted && dateTime != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => DiaryEditorPage(
            diary: Diary(
              createDateTime: dateTime,
              latestEditTime: dateTime,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MercuriusOriginalAppBarUserIconWidget(),
        title: AnimatedCrossFade(
          crossFadeState: _currentSearchBarMode
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
          firstChild: const DiarySearchBarWidget(),
          secondChild: const MercuriusOriginalAppBarTitleWidget(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _currentListViewMode ? _switchCurrentBarMode : null,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: _switchCurrentViewMode,
            icon: Icon(
              _currentListViewMode
                  ? Icons.calendar_month_rounded
                  : Icons.list_alt_rounded,
            ),
          )
        ],
      ),
      body: _currentListViewMode
          ? const DiaryListViewWidget()
          : const DiaryCalendarViewWidget(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        onPressed: _floatingButtonOnPressed,
        child: const Icon(UniconsLine.diary),
      ),
    );
  }
}
