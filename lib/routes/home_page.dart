import 'package:mercurius/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isarService = IsarService();

  bool _currentListViewMode = true;

  void _switchCurrentViewMode() {
    DevTools.printLog('[053] 现在是否为列表视图 $_currentListViewMode 并开始切换');
    setState(() {
      _currentListViewMode = !_currentListViewMode;
    });
    DevTools.printLog('[054] 现在是否为列表视图 $_currentListViewMode 切换完毕');
  }

  void _floatingButtonOnPressed() async {
    var diary = await isarService.isDiaryExisted(DateTime.now());
    if (diary != null) {
      DevTools.printLog('[053] 进入修改模式');
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryEditorPage(diary: diary),
        ),
      );
    } else {
      DevTools.printLog('[054] 进入创建模式');
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryEditorPage(
            diary: Diary()
              ..createDateTime = DateTime.now()
              ..mood = '一般'
              ..weather = locationModel.weatherBody.daily?[0].iconDay ?? '001',
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

  Future<void> _loginDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const LoginDialogWidget();
      },
    );
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
        title: Consumer<LocationModel>(
          builder: (context, locationModel, child) {
            return Column(
              children: [
                const Text(
                  'Mercurius',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Saira',
                  ),
                ),
                InkWell(
                  onTap: () {
                    locationModel.refetchCurrentPosition(true);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        UniconsLine.location_arrow,
                        size: 6,
                      ),
                      Text(
                        " ${(locationModel.position.latitude * 100).toInt() / 100}N ${(locationModel.position.longitude * 100).toInt() / 100}E ",
                        style: const TextStyle(
                          fontSize: 8,
                        ),
                      ),
                      Icon(
                        QWeatherIcon.getIconById(
                              int.parse(
                                locationModel.weatherBody.daily?[0].iconDay ??
                                    '2028',
                              ),
                            ) ??
                            QWeatherIcon.tag_weather_advisory,
                        size: 6,
                      ),
                    ],
                  ),
                ),
                Text(
                  locationModel.geoBody.location?[0].name ?? '',
                  style: const TextStyle(
                    fontSize: 8,
                  ),
                ),
              ],
            );
          },
        ),
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
}
