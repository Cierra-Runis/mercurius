import 'package:mercurius/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'root_page.g.dart';

final splitViewKey = GlobalKey<NavigatorState>();
final _rootPage = GlobalKey();

@riverpod
class CurrentIndex extends _$CurrentIndex {
  @override
  int build() => 0;

  void changeTo(int value) => state = value;
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      child: BasedSplitView(
        navigatorKey: splitViewKey,
        leftWidget: _RootPage(key: _rootPage),
        dividerWidth: 0,
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

class _RootPage extends ConsumerWidget {
  const _RootPage({
    super.key,
  });

  static const bodyWidgets = [
    HomePage(key: PageStorageKey(HomePage)),
    MorePage(key: PageStorageKey(MorePage)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final currentIndex = ref.watch(currentIndexProvider);
    final setCurrentIndex = ref.watch(currentIndexProvider.notifier);

    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: bodyWidgets[currentIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: setCurrentIndex.changeTo,
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
    final githubLatestRelease = ref.watch(githubLatestReleaseProvider);
    final tagName = ref.watch(packageInfoProvider).tagName;
    return Badge(
      isLabelVisible: githubLatestRelease.when(
        loading: () => false,
        error: (error, stackTrace) => false,
        data: (data) => tagName != data.tagName,
      ),
      child: const Icon(Icons.more_horiz),
    );
  }
}
