import 'package:mercurius/index.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MercuriusHomePageState();
}

class _MercuriusHomePageState extends ConsumerState<HomePage> {
  bool _searchBarMode = false;

  void _switchCurrentBarMode() {
    Mercurius.vibration(ref: ref);
    ref.watch(diarySearchTextProvider.notifier).change();
    setState(() => _searchBarMode = !_searchBarMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _switchCurrentBarMode,
          icon: const Icon(Icons.search),
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _searchBarMode
              ? const DiarySearchBarWidget()
              : GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (_) => windowManager.startDragging(),
                  onDoubleTap: windowManager.center,
                  child: const MercuriusAppBarTitleWidget(),
                ),
        ),
        centerTitle: true,
        actions: PlatformWindowsManager.getActions(),
      ),
      body: const DiaryListViewWidget(),
      floatingActionButton: const MercuriusFloatingDiaryButtonWidget(),
    );
  }
}
