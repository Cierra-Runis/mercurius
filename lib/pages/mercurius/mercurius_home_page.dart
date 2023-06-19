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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      floatingActionButton: const MercuriusFloatingDiaryButtonWidget(),
    );
  }
}
