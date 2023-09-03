import 'package:mercurius/index.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});
  @override
  ConsumerState<RootPage> createState() => _MercuriusRouteState();
}

class _MercuriusRouteState extends ConsumerState<RootPage> {
  int _currentIndex = 0;

  static const List<Widget> _bodyWidgets = [
    HomePage(),
    MorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    final List<MercuriusBottomBarItem> bottomWidgets = [
      MercuriusBottomBarItem(
        icon: const Icon(Icons.home),
        title: l10n.homePage,
      ),
      MercuriusBottomBarItem(
        icon: const _MercuriusBottomBarMorePageIconWidget(),
        title: l10n.morePage,
      ),
    ];

    return Scaffold(
      body: Center(
        child: MercuriusDoubleBackWidget(
          message: l10n.backAgainToExit,
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
