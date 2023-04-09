import 'package:mercurius/index.dart';

class DiaryListViewWidget extends StatefulWidget {
  const DiaryListViewWidget({super.key});

  @override
  State<DiaryListViewWidget> createState() => _DiaryListViewWidgetState();
}

class _DiaryListViewWidgetState extends State<DiaryListViewWidget> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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

  Widget _getDiaryListCards(List<Diary>? diaries) {
    List<Widget> diaryListCards = [];
    if (diaries == null || diaries.isEmpty) {
      return const Center(
        child: Text('无数据'),
      );
    }

    for (var diary in diaries) {
      diaryListCards.add(DiaryListCardWidget(diary: diary, diaries: diaries));
    }

    diaryListCards.add(
      Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: const Text('没有更多了'),
        ),
      ),
    );

    return ListView(children: diaryListCards);
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
                return SmartRefresher(
                  onRefresh: () {
                    diarySearchTextNotifier.changeContains(
                      diarySearchTextNotifier.contains,
                    );
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () {
                    _refreshController.loadComplete();
                  },
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
                  child: snapshot.data == null || snapshot.data!.isEmpty
                      ? const Center(
                          child: Text('无数据'),
                        )
                      : ListView.builder(
                          cacheExtent: 1000,
                          itemCount: snapshot.data!.length,
                          itemExtent: 96,
                          itemBuilder: (context, index) => FrameSeparateWidget(
                            index: index,
                            placeHolder:
                                DiaryListCardWidget.getPlaceHolder(context),
                            child: DiaryListCardWidget(
                              diary: snapshot.data![index],
                              diaries: snapshot.data!,
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
