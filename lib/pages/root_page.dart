import 'package:mercurius/index.dart';

final splitViewKey = GlobalKey<NavigatorState>();

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DoubleBack(
      message: l10n.backAgainToExit,
      background: context.colorScheme.outline.withAlpha(16),
      backgroundRadius: BorderRadius.circular(16),
      condition: _currentIndex == 0,
      onConditionFail: () => _onItemTapped(0),
      child: BasedSplitView(
        splitMode: SplitMode.width,
        navigatorKey: splitViewKey,
        leftWidget: RootPage(
          currentIndex: _currentIndex,
          onItemTapped: _onItemTapped,
        ),
        leftWidth: 364,
        breakPoint: 364 * 2,
        rightPlaceholder: const Scaffold(
          body: Center(
            child: AppIcon(
              size: 96,
            ),
          ),
        ),
      ),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  final int currentIndex;
  final void Function(int) onItemTapped;

  static const List<Widget> _bodyWidgets = [
    HomePage(key: ValueKey(HomePage)),
    MorePage(key: ValueKey(MorePage)),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _bodyWidgets[currentIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onItemTapped,
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
