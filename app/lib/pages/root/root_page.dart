import 'package:mercurius/index.dart';

final _rootPage = GlobalKey();

class RootPage extends HookWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasedSplitView(
      navigatorKey: App.splitViewKey,
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentIndex = useState(0);
    final controller = useScrollController();

    final bodyWidgets = [
      HomePage(key: PageStorageKey(HomePage), controller: controller),
      CalendarPage(key: PageStorageKey(CalendarPage)),
    ];

    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: Durations.medium2,
          child: bodyWidgets[currentIndex.value],
        ),
      ),
      bottomNavigationBar: _ScrollToHide(
        controller: controller,
        child: NavigationBar(
          selectedIndex: currentIndex.value,
          onDestinationSelected: (value) => currentIndex.value = value,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: l10n.homePage,
            ),
            NavigationDestination(
              icon: const Icon(Icons.calendar_month_rounded),
              label: l10n.calendar,
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrollToHide extends HookWidget {
  final Widget child;
  final ScrollController controller;

  const _ScrollToHide({
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final _ = useListenable(controller);
    if (!controller.hasClients) {
      return child;
    }

    final direction = controller.position.userScrollDirection;

    return AnimatedContainer(
      height: switch (direction) {
        ScrollDirection.forward || ScrollDirection.idle => 80,
        ScrollDirection.reverse => 0.0,
      },
      duration: Durations.short4,
      curve: Curves.easeInOut,
      child: Wrap(children: [child]),
    );
  }
}
