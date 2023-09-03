import 'package:mercurius/index.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MercuriusHomePageState();
}

class _MercuriusHomePageState extends ConsumerState<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          tooltip: l10n.notYetCompleted,
          icon: const Icon(Icons.search),
        ),
        title: MercuriusAppBarTitleWidget(
          scrollController: scrollController,
        ),
        actions: PlatformWindowsManager.getActions(),
      ),
      body: DiaryListViewWidget(
        scrollController: scrollController,
      ),
      floatingActionButton: const MercuriusFloatingDiaryButtonWidget(),
    );
  }
}
