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
        leading: IconButton(
          icon: const Icon(UniconsLine.user_circle),
          onPressed: () {},
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
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child:
            Consumer4<ProfileModel, MercuriusWebModel, LocationModel, LogModel>(
          builder: (
            context,
            profileModel,
            mercuriusWebModel,
            locationModel,
            logModel,
            child,
          ) {
            return ListView(
              children: [
                InkWell(
                  onLongPress: () {
                    logModel.clearLog();
                  },
                  child: ListTile(
                    title: Text(
                      logModel.logString,
                      style: const TextStyle(
                        fontSize: 8,
                        fontFamily: 'Saira',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    jsonEncode(profileModel.profile),
                    style: const TextStyle(
                      fontSize: 8,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    jsonEncode(mercuriusWebModel.githubLatestRelease),
                    style: const TextStyle(
                      fontSize: 8,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    jsonEncode(locationModel.weatherBody.daily?[0].textDay),
                    style: const TextStyle(
                      fontSize: 8,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    jsonEncode(locationModel.weatherBody),
                    style: const TextStyle(
                      fontSize: 8,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    jsonEncode(locationModel.geoBody),
                    style: const TextStyle(
                      fontSize: 8,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    jsonEncode(locationModel.position),
                    style: const TextStyle(
                      fontSize: 8,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
