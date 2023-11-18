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
    final l10n = L10N.current;
    final path = ref.watch(mercuriusPathProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: null,
          tooltip: l10n.notYetCompleted,
          icon: const Icon(Icons.search),
        ),
        title: AppBarTitle(
          controller: controller,
        ),
      ),
      body: ClipRRect(
        child: DecoratedBox(
          decoration: settings.bgImgPath != null
              ? path.when(
                  loading: BoxDecoration.new,
                  error: (error, stackTrace) => const BoxDecoration(),
                  data: (data) => BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.8,
                      image: FileImage(
                        File('$data/image/${settings.bgImgPath}'),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : const BoxDecoration(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: DiaryListView(controller: controller),
          ),
        ),
      ),
      floatingActionButton: const FloatingDiaryButton(),
    );
  }
}
