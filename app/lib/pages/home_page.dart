import 'package:mercurius/index.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;
    final path = ref.watch(pathsProvider);
    final settings = ref.watch(settingsProvider);
    final controller = useScrollController();

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
          decoration: settings.bgImgId != null
              ? BoxDecoration(
                  image: DecorationImage(
                    opacity: 0.8,

                    /// TODO:
                    image: FileImage(
                      File('$path/image/${settings.bgImgId}'),
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : const BoxDecoration(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: DiaryListView(
              controller: controller,
            ),
          ),
        ),
      ),
      floatingActionButton: const FloatingDiaryButton(),
    );
  }
}
