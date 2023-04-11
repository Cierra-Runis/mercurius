import 'package:mercurius/index.dart';

class MercuriusHomePage extends StatefulWidget {
  const MercuriusHomePage({super.key});

  @override
  State<MercuriusHomePage> createState() => _MercuriusHomePageState();
}

class _MercuriusHomePageState extends State<MercuriusHomePage> {
  bool _currentListViewMode = true;
  bool _currentSearchBarMode = false;

  void _switchCurrentViewMode() {
    MercuriusKit.vibration();
    diarySearchTextNotifier.changeContains('');

    setState(() {
      _currentListViewMode = !_currentListViewMode;
      _currentSearchBarMode = false;
    });
  }

  void _switchCurrentBarMode() {
    MercuriusKit.vibration();
    diarySearchTextNotifier.changeContains('');

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
        MaterialPageRoute(
          builder: (context) => DiaryEditorPage(
            diary: Diary(
              createDateTime: dateTime,
              latestEditTime: dateTime,
              mood: '一般',
              weather: '100',
            ),
          ),
        ),
      );
    }
  }

  void _appBarLeftButtonOnPressed() {
    MercuriusKit.vibration();
    if (mercuriusProfileNotifier.profile.user == null) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const DialogLoginWidget();
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MercuriusProfilePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<MercuriusProfileNotifier>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: _appBarLeftButtonOnPressed,
            );
          },
        ),
        title: _currentSearchBarMode
            ? const DiarySearchBarWidget()
            : const MercuriusOriginalTitleWidget(),
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
      drawer: const DevLogDrawerWidget(),
    );
  }
}
