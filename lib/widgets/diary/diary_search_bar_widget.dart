import 'package:mercurius/index.dart';

class DiarySearchBarWidget extends ConsumerWidget {
  const DiarySearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

    return SizedBox(
      width: 160,
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        onChanged: (value) =>
            ref.watch(diarySearchTextProvider.notifier).change(value),
        decoration: InputDecoration(
          hintText: l10n.searchDiaryContent,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
