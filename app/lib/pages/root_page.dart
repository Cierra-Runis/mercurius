import 'package:mercurius/index.dart';

final splitViewKey = GlobalKey<NavigatorState>();
final _rootPage = GlobalKey();

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasedSplitView(
      navigatorKey: splitViewKey,
      leftWidget: _RootPage(key: _rootPage),
      dividerWidth: 0,
      rightPlaceholder: const Scaffold(
        body: Center(child: AppIcon(size: 96)),
      ),
    );
  }
}

class _RootPage extends HookWidget {
  const _RootPage({super.key});

  static const bodyWidgets = [
    HomePage(key: PageStorageKey(HomePage)),
    MorePage(key: PageStorageKey(MorePage)),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentIndex = useState(0);

    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: bodyWidgets[currentIndex.value],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex.value,
        onDestinationSelected: (value) => currentIndex.value = value,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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
    final gitHubLatestRelease = ref.watch(gitHubLatestReleaseProvider);
    final tagName = ref.watch(packageInfoProvider).tagName;
    return Badge(
      isLabelVisible: gitHubLatestRelease.when(
        loading: () => false,
        error: (error, stackTrace) => false,
        data: (data) => tagName != data.tagName,
      ),
      child: const Icon(Icons.more_horiz),
    );
  }
}
