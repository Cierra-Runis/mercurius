import 'package:mercurius/index.dart';

class DiaryPageView extends ConsumerWidget {
  const DiaryPageView({
    super.key,
    required this.diary,
  });

  final Diary diary;

  Widget _getPageBySnapshotData(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
  ) {
    final l10n = L10N.current;

    if (snapshot.data == null || snapshot.data!.isEmpty) {
      return AlertDialog(title: Center(child: Text(l10n.noData)));
    }

    final diaries = snapshot.data!;

    /// FIXME: 问题见 https://github.com/flutter/flutter/issues/45632
    return PageView.builder(
      itemCount: diaries.length,
      controller: PageController(
        initialPage: diaries.indexWhere((e) => e.id == diary.id),
      ),
      allowImplicitScrolling: true,
      itemBuilder: (context, index) => DiaryPageItem(
        key: ValueKey(diaries[index].id),
        diary: diaries[index],
      ),
    );
  }

  Widget _getBodyBySnapshotState(
    BuildContext context,
    AsyncSnapshot<List<Diary>> snapshot,
  ) {
    if (snapshot.hasError) {
      return Center(child: Text('Steam error: ${snapshot.error}'));
    }
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const Center(child: Icon(UniconsLine.data_sharing));
      case ConnectionState.waiting:
        return const Loading();
      case ConnectionState.active:
        return _getPageBySnapshotData(context, snapshot);
      case ConnectionState.done:
        return const Center(child: Text('Stream closed'));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Diary>>(
      stream: isarService.listenToAllDiaries(),
      builder: _getBodyBySnapshotState,
    );
  }
}
