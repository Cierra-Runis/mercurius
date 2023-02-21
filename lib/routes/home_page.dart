import 'package:mercurius/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _currentListViewMode = true;
  bool _currentSearchBarMode = false;

  void _switchCurrentViewMode() {
    diarySearchTextModel.changeContains('');
    Vibration.vibrate(duration: 50, amplitude: 255);
    DevTools.printLog('现在是否为列表视图 $_currentListViewMode 并开始切换');
    setState(() {
      _currentListViewMode = !_currentListViewMode;
      _currentSearchBarMode = false;
    });
    DevTools.printLog('现在是否为列表视图 $_currentListViewMode 切换完毕');
  }

  void _switchCurrentBarMode() {
    Vibration.vibrate(duration: 50, amplitude: 255);
    diarySearchTextModel.changeContains('');
    DevTools.printLog('现在是否为搜索组件 $_currentSearchBarMode 并开始切换');
    setState(() {
      _currentSearchBarMode = !_currentSearchBarMode;
    });
    DevTools.printLog('现在是否为搜索组件 $_currentSearchBarMode 切换完毕');
  }

  void _floatingButtonOnPressed() async {
    Vibration.vibrate(duration: 50, amplitude: 255);
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
      // FIXME: 解决该问题
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
    Vibration.vibrate(duration: 50, amplitude: 255);
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
        title: _currentSearchBarMode
            ? SizedBox(
                width: 160,
                child: TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  onChanged: (value) =>
                      diarySearchTextModel.changeContains(value),
                  decoration: const InputDecoration(
                    hintText: '查找日记内容',
                    border: InputBorder.none,
                  ),
                ),
              )
            : const MercuriusTitleWidget(),
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

  Future<void> _loginDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LoginDialogWidget();
      },
    );
  }
}
