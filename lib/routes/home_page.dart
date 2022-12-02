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
    setState(() {
      _currentListViewMode = !_currentListViewMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getDiaryListCards(List<Diary>? data) {
      List<DiaryListCardWidget> diaryListCards =
          List<DiaryListCardWidget>.from([]);
      if (data == null || data.isEmpty) {
        return const Center(
          child: Text('无数据'),
        );
      }

      for (var element in data) {
        diaryListCards.add(DiaryListCardWidget(diary: element));
      }

      ListView listView = ListView(
        children: diaryListCards.reversed.toList(),
      );

      return listView;
    }

    return Scaffold(
      appBar: AppBar(
        leading: Consumer<ProfileModel>(
          builder: (context, value, child) {
            return IconButton(
              icon: const Icon(UniconsLine.user_circle),
              onPressed: () {
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
              },
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
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              DevTools.printLog('[053] 现在是否为列表视图 $_currentListViewMode 并开始切换');
              _switchCurrentViewMode();
              DevTools.printLog('[054] 现在是否为列表视图 $_currentListViewMode 切换完毕');
            },
            icon: Icon(
              _currentListViewMode
                  ? Icons.calendar_month_rounded
                  : Icons.list_alt_rounded,
            ),
          )
        ],
      ),
      body: _currentListViewMode
          ? StreamBuilder<List<Diary>>(
              stream: isarService.listenToDiaries(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Diary>> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Icon(UniconsLine.data_sharing),
                    );
                  case ConnectionState.waiting:
                    return Container();
                  case ConnectionState.active:
                    return getDiaryListCards(snapshot.data);
                  case ConnectionState.done:
                    return const Text('Stream 已关闭');
                }
              },
            )
          : const Center(
              // TODO: 写日历视图
              child: Text('日历视图'),
            ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Icon(UniconsLine.diary),
        onPressed: () async {
          var a = await isarService.isDiaryExisted(DateTime.now());
          if (a[0]) {
            DevTools.printLog('[053] 进入修改模式');
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiaryEditorPage(diary: a[1]),
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
                    ..createDateTime = DateTime.now().toString()
                    ..mood = '一般'
                    ..weather =
                        locationModel.weatherBody.daily?[0].iconDay ?? '001',
                ),
              ),
            );
          }
        },
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
