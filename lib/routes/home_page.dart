import 'package:mercurius/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _currentListViewMode = true;

  final isarService = IsarService();

  void _switchCurrentViewMode() {
    DevTools.printLog('现在是否为列表视图 $_currentListViewMode 并开始切换');
    setState(() {
      _currentListViewMode = !_currentListViewMode;
    });
    DevTools.printLog('现在是否为列表视图 $_currentListViewMode 切换完毕');
  }

  void _floatingButtonOnPressed() async {
    var diary = await isarService.isDiaryExisted(DateTime.now());
    if (diary != null) {
      DevTools.printLog('进入修改模式');
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryEditorPage(diary: diary),
        ),
      );
    } else {
      DevTools.printLog('进入创建模式');
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryEditorPage(
            diary: Diary()
              ..createDateTime = DateTime.now()
              ..mood = '一般'
              ..weather = '001',
          ),
        ),
      );
    }
  }

  void _appBarLeftButtonOnPressed() {
    if (profileModel.profile.user == null) {
      _loginDialog(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ProfileModel>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: _appBarLeftButtonOnPressed,
            );
          },
        ),
        title: const MercuriusTitleWidget(),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              /// TODO: 搜索功能
            },
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
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: _floatingButtonOnPressed,
        child: const Icon(UniconsLine.diary),
      ),
      drawer: const DevLogDrawerWidget(),
    );
  }

  Future<void> _loginDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LoginDialogWidget();
      },
    );
  }
}
