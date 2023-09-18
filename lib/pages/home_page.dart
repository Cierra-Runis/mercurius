import 'package:mercurius/index.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _MercuriusHomePageState();
}

class _MercuriusHomePageState extends ConsumerState<HomePage> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          tooltip: l10n.notYetCompleted,
          icon: const Icon(Icons.search),
        ),
        title: MercuriusAppBarTitleWidget(
          controller: controller,
        ),
        actions: PlatformWindowsManager.getActions(),
      ),
      body: DiaryListViewWidget(
        controller: controller,
      ),
      floatingActionButton: const MercuriusFloatingDiaryButtonWidget(),
    );
  }
}
