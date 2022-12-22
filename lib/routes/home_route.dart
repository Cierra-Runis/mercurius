import 'package:mercurius/index.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({super.key});
  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MorePage(),
  ];

  void _onItemTapped(int index) {
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
          onConditionFail: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
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
              barBlur: 4.0,
              borderRadius: BorderRadius.circular(16),
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF303030).withAlpha(60)
                  : const Color(0xFFCFCFCF).withAlpha(60),
              boxShadows: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: 4.0,
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
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? darkColorScheme.onInverseSurface
            : lightColorScheme.surface,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Consumer2<ProfileModel, MercuriusWebModel>(
              builder: (context, profileModel, mercuriusWebModel, child) =>
                  Badge(
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
