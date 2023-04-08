import 'package:mercurius/index.dart';

class MercuriusRoute extends StatefulWidget {
  const MercuriusRoute({super.key});
  @override
  State<MercuriusRoute> createState() => _MercuriusRouteState();
}

class _MercuriusRouteState extends State<MercuriusRoute> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    MercuriusHomePage(),
    MercuriusMorePage(),
  ];

  void _onItemTapped(int index) {
    MercuriusKit.vibration();
    diarySearchTextNotifier.changeContains('');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MercuriusDoubleBackWidget(
          background: Theme.of(context).colorScheme.outline.withAlpha(16),
          backgroundRadius: BorderRadius.circular(16),
          condition: _selectedIndex == 0,
          onConditionFail: () => setState(() {
            _selectedIndex = 0;
          }),
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: MercuriusBottomBarWidget(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.outline,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: [
          MercuriusBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text(
              '主页',
              style: TextStyle(fontFamily: 'Saira'),
            ),
          ),
          MercuriusBottomBarItem(
            icon: Consumer2<MercuriusProfileNotifier, MercuriusWebNotifier>(
              builder: (
                context,
                mercuriusProfileNotifier,
                mercuriusWebNotifier,
                child,
              ) {
                return Badge(
                  showBadge: mercuriusProfileNotifier.profile.currentVersion !=
                      mercuriusWebNotifier.githubLatestRelease.tag_name,
                  child: const Icon(Icons.more_horiz),
                );
              },
            ),
            title: const Text(
              '更多',
              style: TextStyle(fontFamily: 'Saira'),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
