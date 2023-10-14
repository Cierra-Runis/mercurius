import 'package:mercurius/index.dart';

class MoodSelectorWidget extends ConsumerWidget {
  const MoodSelectorWidget({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.howIsYourMoodNow),
          Text(
            l10n.howIsYourMoodNowDescription,
            style: TextStyle(
              fontSize: 10,
              color: context.colorScheme.outline,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: DiaryMoodType.values.length,
          itemBuilder: (context, index) {
            DiaryMoodType moodType = DiaryMoodType.values[index];
            return IconButton(
              onPressed: () => context.pop(
                Diary.copyWith(diary, moodType: moodType),
              ),
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(moodType.iconData),
                  Text(l10n.moodText(moodType.mood)),
                ],
              ),
              color: diary.moodType != moodType
                  ? null
                  : context.colorScheme.primary,
            );
          },
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(l10n.back),
        ),
      ],
    );
  }
}
