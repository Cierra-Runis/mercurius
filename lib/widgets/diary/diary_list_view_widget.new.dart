import 'package:mercurius/index.dart';

class DiaryListViewWidget extends StatefulWidget {
  const DiaryListViewWidget({super.key});

  @override
  State<DiaryListViewWidget> createState() => _DiaryListViewWidgetState();
}

class _DiaryListViewWidgetState extends State<DiaryListViewWidget> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  late List<Widget> diaryListCards;
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    setState(() {
      diaryListCards = [];
      dateTime = DateTime.now().add(const Duration(days: 20000));
    });
  }

  Widget _getFooterChild(LoadStatus? mode) {
    switch (mode) {
      case LoadStatus.idle:
        return const Text('上拉获取');
      case LoadStatus.loading:
        return LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).colorScheme.primary,
          size: 16,
        );
      case LoadStatus.failed:
        return const Text('获取失败');
      case LoadStatus.canLoading:
        return const Text('松手获取');
      case LoadStatus.noMore:
        return const Text('没有更多了');
      default:
        return const Text('没有更多了');
    }
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading(String contains, DateTime dateTime) async {
    await Future.delayed(const Duration(milliseconds: 100));
    List<Diary> newDiaries = await isarService.getDiariesContainsOlderThan(
      contains,
      dateTime,
    );
    if (newDiaries.isNotEmpty) {
      for (Diary diary in newDiaries) {
        diaryListCards.add(
          DiaryListCardWidget(diary: diary, diaries: newDiaries),
        );
      }
      if (mounted) {
        setState(() {
          this.dateTime = newDiaries.last.createDateTime!;
        });
      }
    } else {
      _refreshController.loadNoData();
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiarySearchTextNotifier>(
      builder: (context, diarySearchTextNotifier, child) {
        return StreamBuilder<List<Diary>>(
          stream: isarService
              .listenToDiariesContains(diarySearchTextNotifier.contains),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Diary>> snapshot,
          ) {
            if (snapshot.hasError) {
              return Center(child: Text('Steam 错误: ${snapshot.error}'));
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Icon(UniconsLine.data_sharing));
              case ConnectionState.waiting:
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: Theme.of(context).colorScheme.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 20),
                      const Text('读取中'),
                    ],
                  ),
                );
              case ConnectionState.active:
                return SizeCacheWidget(
                  estimateCount: 20,
                  child: SmartRefresher(
                    onRefresh: _onRefresh,
                    onLoading: () =>
                        _onLoading(diarySearchTextNotifier.contains, dateTime),
                    footer: CustomFooter(
                      loadStyle: LoadStyle.ShowWhenLoading,
                      builder: (context, mode) {
                        return Container(
                          alignment: Alignment.center,
                          height: 60,
                          child: _getFooterChild(mode),
                        );
                      },
                    ),
                    controller: _refreshController,
                    enablePullUp: true,
                    child: diaryListCards.isEmpty
                        ? const Center(
                            child: Text('无数据'),
                          )
                        : ListView.builder(
                            cacheExtent: 1000,
                            itemCount: diaryListCards.length,
                            itemExtent: 96,
                            itemBuilder: (context, index) =>
                                FrameSeparateWidget(
                              index: index,
                              placeHolder:
                                  DiaryListCardWidget.getPlaceHolder(context),
                              child: diaryListCards[index],
                            ),
                          ),
                  ),
                );
              case ConnectionState.done:
                return const Center(child: Text('Stream 已关闭'));
            }
          },
        );
      },
    );
  }
}

class _DiaryDateTag extends StatelessWidget {
  const _DiaryDateTag({
    Key? key,
    required this.year,
    required this.month,
    this.margin,
  }) : super(key: key);

  final int year;
  final int month;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.fromLTRB(24, 0, 10, 0),
      child: Text(
        '$year年$month月',
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Saira',
        ),
      ),
    );
  }
}
