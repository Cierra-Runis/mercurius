import 'package:mercurius/index.dart';

class DiaryMoodSelectorWidget extends ConsumerWidget {
  /// 自定义组件
  const DiaryMoodSelectorWidget({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);

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
              color: Theme.of(context).colorScheme.outline,
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
              onPressed: () => Navigator.of(context).pop(
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
                  : Theme.of(context).colorScheme.primary,
            );
          },
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      actions: [
        TextButton(
          onPressed: () {
            Mercurius.vibration(ref: ref);
            Navigator.of(context).pop();
          },
          child: Text(l10n.back),
        ),
      ],
    );
  }
}
