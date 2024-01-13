import 'package:mercurius/index.dart';

class MoodSelector extends ConsumerWidget {
  const MoodSelector({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10N.maybeOf(context) ?? L10N.current;

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
            final moodType = DiaryMoodType.values[index];
            return IconButton(
              tooltip: l10n.moodText(moodType.mood),
              onPressed: () => context.pop(moodType),
              icon: Icon(moodType.iconData),
              color: diary.moodType.name == moodType.name
                  ? context.colorScheme.primary
                  : null,
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
