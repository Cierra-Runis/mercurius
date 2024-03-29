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

class RootView extends ConsumerWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DoubleBack(
      child: BasedSplitView(
        navigatorKey: splitViewKey,
        leftWidget: RootPage(key: _rootPage),
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

class RootPage extends ConsumerWidget {
  const RootPage({
    super.key,
  });

  static const bodyWidgets = [
    HomePage(key: ValueKey(HomePage)),
    MorePage(key: ValueKey(MorePage)),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;
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
