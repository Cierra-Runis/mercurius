import 'package:mercurius/index.dart';

class DiaryWeatherSelectorDialogWidget extends ConsumerWidget {
  const DiaryWeatherSelectorDialogWidget({
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
          Text(l10n.whatIsTheWeatherNow),
          Text(
            l10n.whatIsTheWeatherNowDescription,
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
          itemCount: DiaryWeatherType.values.length,
          itemBuilder: (context, index) {
            DiaryWeatherType weatherType = DiaryWeatherType.values[index];
            return IconButton(
              onPressed: () => Navigator.of(context).pop(
                Diary.copyWith(diary, weatherType: weatherType),
              ),
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(weatherType.qweatherIcons.iconData),
                  Text(l10n.weatherText(weatherType.weather)),
                ],
              ),
              color: diary.weatherType != weatherType
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
