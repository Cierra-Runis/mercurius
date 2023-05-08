import 'package:mercurius/index.dart';

class DiarySearchBarWidget extends ConsumerWidget {
  const DiarySearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 160,
      child: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        onChanged: (value) =>
            ref.watch(diarySearchTextProvider.notifier).change(value),
        decoration: const InputDecoration(
          hintText: '查找日记内容',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
