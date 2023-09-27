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
    final path = ref.watch(mercuriusPathProvider);

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
      body: StreamBuilder(
        stream: isarService.listenToConfig(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: path.when(
                loading: () => null,
                error: (error, stackTrace) => null,
                data: (data) => BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.8,
                    image: FileImage(
                      File('$data/image/${snapshot.data?.backgroundImagePath}'),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: DiaryListViewWidget(controller: controller),
              ),
            );
          }
          return const MercuriusLoadingWidget();
        },
      ),
      floatingActionButton: const MercuriusFloatingDiaryButtonWidget(),
    );
  }
}
