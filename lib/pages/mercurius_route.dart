import 'package:mercurius/index.dart';

class MercuriusRoute extends ConsumerStatefulWidget {
  const MercuriusRoute({super.key});
  @override
  ConsumerState<MercuriusRoute> createState() => _MercuriusRouteState();
}

class _MercuriusRouteState extends ConsumerState<MercuriusRoute> {
  int _selectedIndex = 0;

  static const List<Widget> _bodyWidgets = [
    MercuriusHomePage(),
    MercuriusMorePage(),
  ];

  static const _bottomWidgets = [
    MercuriusBottomBarItem(icon: Icon(Icons.home), title: '主页'),
    MercuriusBottomBarItem(
      icon: _MercuriusBottomBarMorePageIconWidget(),
      title: '更多',
    ),
  ];

  void _onItemTapped(int index) {
    Mercurius.vibration(ref: ref);
    ref.watch(diarySearchTextProvider.notifier).change();
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MercuriusDoubleBackWidget(
          background: Theme.of(context).colorScheme.outline.withAlpha(16),
          backgroundRadius: BorderRadius.circular(16),
          condition: _selectedIndex == 0,
          onConditionFail: () => setState(() => _selectedIndex = 0),
          child: _bodyWidgets[_selectedIndex],
        ),
      ),
      bottomNavigationBar: MercuriusBottomBarWidget(
        colorScheme: Theme.of(context).colorScheme,
        items: _bottomWidgets,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _MercuriusBottomBarMorePageIconWidget extends ConsumerWidget {
  const _MercuriusBottomBarMorePageIconWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final currentVersion = ref.watch(currentVersionProvider);
    return Badge(
      showBadge: githubLatestRelease.when(
        loading: () => false,
        error: (error, stackTrace) => false,
        data: (githubLatestRelease) => currentVersion.when(
          loading: () => false,
          error: (error, stackTrace) => false,
          data: (currentVersion) =>
              currentVersion != githubLatestRelease.tag_name,
        ),
      ),
      child: const Icon(Icons.more_horiz),
    );
  }
}
