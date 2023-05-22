import 'package:mercurius/index.dart';

class MercuriusHomePage extends ConsumerStatefulWidget {
  const MercuriusHomePage({super.key});

  @override
  ConsumerState<MercuriusHomePage> createState() => _MercuriusHomePageState();
}

class _MercuriusHomePageState extends ConsumerState<MercuriusHomePage> {
  bool _currentSearchBarMode = false;

  void _switchCurrentBarMode() {
    Mercurius.vibration(ref: ref);
    ref.watch(diarySearchTextProvider.notifier).change();
    setState(() => _currentSearchBarMode = !_currentSearchBarMode);
  }

  void _floatingButtonOnPressed() async {
    Mercurius.vibration(ref: ref);

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
              id: Isar.autoIncrement,
              createDateTime: dateTime,
              latestEditTime: dateTime,
              contentJsonString: jsonEncode(Document().toDelta().toJson()),
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
        leading: const IconButton(
          icon: Icon(UniconsLine.user_circle),
          onPressed: null,
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _currentSearchBarMode
              ? const DiarySearchBarWidget()
              : const MercuriusAppBarTitleWidget(),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _switchCurrentBarMode,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: const DiaryListViewWidget(),
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
