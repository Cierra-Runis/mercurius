import 'package:mercurius/index.dart';

class MercuriusRoute extends ConsumerStatefulWidget {
  const MercuriusRoute({super.key});
  @override
  ConsumerState<MercuriusRoute> createState() => _MercuriusRouteState();
}

class _MercuriusRouteState extends ConsumerState<MercuriusRoute> {
  int _currentIndex = 0;

  static const List<Widget> _bodyWidgets = [
    MercuriusHomePage(),
    MercuriusMorePage(),
  ];

  void _onItemTapped(int index) {
    Mercurius.vibration(ref: ref);
    ref.watch(diarySearchTextProvider.notifier).change();
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final S localizations = S.of(context);

    final List<MercuriusBottomBarItem> bottomWidgets = [
      MercuriusBottomBarItem(
        icon: const Icon(Icons.home),
        title: localizations.homePage,
      ),
      MercuriusBottomBarItem(
        icon: const _MercuriusBottomBarMorePageIconWidget(),
        title: localizations.morePage,
      ),
    ];

    return Scaffold(
      body: Center(
        child: MercuriusDoubleBackWidget(
          background: Theme.of(context).colorScheme.outline.withAlpha(16),
          backgroundRadius: BorderRadius.circular(16),
          condition: _currentIndex == 0,
          onConditionFail: () => setState(() => _currentIndex = 0),
          child: _bodyWidgets[_currentIndex],
        ),
      ),
      bottomNavigationBar: MercuriusBottomBarWidget(
        colorScheme: Theme.of(context).colorScheme,
        bottomWidgets: bottomWidgets,
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class _MercuriusBottomBarMorePageIconWidget extends ConsumerWidget {
  const _MercuriusBottomBarMorePageIconWidget();

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
