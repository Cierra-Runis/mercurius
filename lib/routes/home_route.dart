import 'package:mercurius/index.dart';

import 'package:badges/badges.dart' as badge; // 小红点提示

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});
  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomePage(),
    MorePage(),
  ];

  void _onItemTapped(int index) {
    Vibration.vibrate(duration: 50, amplitude: 255);
    diarySearchTextModel.changeContains('');
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Consumer2<ProfileModel, MercuriusWebModel>(
              builder: (context, profileModel, mercuriusWebModel, child) =>
                  badge.Badge(
                showBadge: profileModel.profile.currentVersion !=
                    mercuriusWebModel.githubLatestRelease.tag_name,
                child: const Icon(Icons.more_horiz),
              ),
            ),
            label: '更多',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
