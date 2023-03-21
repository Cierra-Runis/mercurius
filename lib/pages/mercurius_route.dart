import 'package:mercurius/index.dart';

import 'package:badges/badges.dart' as badge; // 小红点提示

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
    Vibration.vibrate(duration: 50, amplitude: 255);
    diarySearchTextNotifier.changeContains('');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DoubleBack(
          condition: _selectedIndex == 0,
          onConditionFail: () => setState(() {
            _selectedIndex = 0;
          }),
          onFirstBackPress: (context) {
            Flushbar(
              icon: const Icon(UniconsLine.exit),
              isDismissible: false,
              messageText: const Center(
                child: Text(
                  '再次返回以退出',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(60, 0, 60, 70),
              barBlur: 1.0,
              borderRadius: BorderRadius.circular(16),
              backgroundColor:
                  Theme.of(context).colorScheme.outline.withAlpha(16),
              boxShadows: const [
                BoxShadow(
                  color: Colors.transparent,
                  offset: Offset(0, 16),
                ),
              ],
              duration: const Duration(
                milliseconds: 600,
              ),
            ).show(context);
          },
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
              builder: (context, mercuriusProfileNotifier, mercuriusWebNotifier,
                      child) =>
                  badge.Badge(
                showBadge: mercuriusProfileNotifier.profile.currentVersion !=
                    mercuriusWebNotifier.githubLatestRelease.tag_name,
                child: const Icon(Icons.more_horiz),
              ),
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
