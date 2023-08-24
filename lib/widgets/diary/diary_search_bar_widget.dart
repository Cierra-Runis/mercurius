import 'package:mercurius/index.dart';

class DiarySearchBarWidget extends ConsumerWidget {
  const DiarySearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (value) =>
                ref.watch(diarySearchTextProvider.notifier).change(
                      ref.watch(diarySearchTextProvider).copyWith(text: value),
                    ),
            decoration: InputDecoration(
              hintText: l10n.searchDiary,
              border: InputBorder.none,
            ),
          ),
        ),
        StarMenu(
          params: StarMenuParameters.dropdown(context).copyWith(
            boundaryBackground: BoundaryBackground(
              blurSigmaX: 4,
              blurSigmaY: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: colorScheme.outlineVariant.withAlpha(32),
              ),
            ),
            linearShapeParams: const LinearShapeParams(
              space: 4,
              angle: -90,
            ),
            centerOffset: const Offset(0, 40),
            closeDurationMs: 200,
          ),
          onItemTapped: (index, controller) => controller.closeMenu!(),
          lazyItems: () async {
            final diarySearch = ref.watch(diarySearchTextProvider);
            return [
              BaseChipWidget(
                leadingIconData: diarySearch.searchTitle ? Icons.check : null,
                label: l10n.searchTitle,
                onTap: () => ref.watch(diarySearchTextProvider.notifier).change(
                      diarySearch.copyWith(
                        searchTitle: !diarySearch.searchTitle,
                      ),
                    ),
              ),
            ];
          },
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.expand_more_rounded),
          ),
        ),
      ],
    );
  }
}
