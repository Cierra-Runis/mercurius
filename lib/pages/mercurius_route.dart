import 'package:mercurius/index.dart';

class MercuriusRoute extends ConsumerStatefulWidget {
  const MercuriusRoute({super.key});
  @override
  ConsumerState<MercuriusRoute> createState() => _MercuriusRouteState();
}

class _MercuriusRouteState extends ConsumerState<MercuriusRoute> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    MercuriusHomePage(),
    MercuriusMorePage(),
  ];

  void _onItemTapped(int index) {
    MercuriusKit.vibration();
    ref.watch(diarySearchTextProvider.notifier).change();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DevLogDrawerWidget(),
      drawerEdgeDragWidth: 120,
      body: Center(
        child: MercuriusModifiedDoubleBackWidget(
          background: Theme.of(context).colorScheme.outline.withAlpha(16),
          backgroundRadius: BorderRadius.circular(16),
          condition: _selectedIndex == 0,
          onConditionFail: () => setState(() {
            _selectedIndex = 0;
          }),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: MercuriusModifiedBottomBarWidget(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.outline,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: const [
          MercuriusBottomBarItem(
            icon: Icon(Icons.home),
            title: Text(
              '主页',
              style: TextStyle(fontFamily: 'Saira'),
            ),
          ),
          _MercuriusBottomBarMorePageItem(),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _MercuriusBottomBarMorePageItem extends MercuriusBottomBarItem {
  const _MercuriusBottomBarMorePageItem()
      : super(
          icon: const _MercuriusBottomBarMorePageItemIconWidget(),
          title: const Text(
            '更多',
            style: TextStyle(fontFamily: 'Saira'),
          ),
        );
}

class _MercuriusBottomBarMorePageItemIconWidget extends ConsumerWidget {
  const _MercuriusBottomBarMorePageItemIconWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final mercuriusProfile = ref.watch(mercuriusProfileProvider);
    return Badge(
      showBadge: githubLatestRelease.when(
        loading: () => false,
        error: (error, stackTrace) => false,
        data: (githubLatestRelease) => mercuriusProfile.when(
          loading: () => false,
          error: (error, stackTrace) => false,
          data: (profile) =>
              profile.currentVersion != githubLatestRelease.tag_name,
        ),
      ),
      child: const Icon(Icons.more_horiz),
    );
  }
}
