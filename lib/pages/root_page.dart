import 'package:mercurius/index.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});
  @override
  ConsumerState<RootPage> createState() => _MercuriusRouteState();
}

class _MercuriusRouteState extends ConsumerState<RootPage> {
  int _currentIndex = 0;

  static const List<Widget> _bodyWidgets = [
    HomePage(key: ValueKey(HomePage)),
    MorePage(key: ValueKey(MorePage)),
  ];

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: Center(
        child: DoubleBack(
          message: l10n.backAgainToExit,
          background: context.colorScheme.outline.withAlpha(16),
          backgroundRadius: BorderRadius.circular(16),
          condition: _currentIndex == 0,
          onConditionFail: () => setState(() => _currentIndex = 0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _bodyWidgets[_currentIndex],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: l10n.homePage,
          ),
          NavigationDestination(
            icon: const _BottomBarMorePageIcon(),
            label: l10n.morePage,
          ),
        ],
      ),
    );
  }
}

class _BottomBarMorePageIcon extends ConsumerWidget {
  const _BottomBarMorePageIcon();

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
