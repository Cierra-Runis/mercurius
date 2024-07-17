import 'package:mercurius/index.dart';

class DiaryListItem extends StatelessWidget {
  const DiaryListItem({
    super.key,
    required this.diary,
    this.dismissDirection = DismissDirection.none,
    this.onTap,
  });

  final Diary diary;
  final DismissDirection dismissDirection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;

    return Dismissible(
      key: ValueKey(diary.id),
      direction: dismissDirection,
      movementDuration: const Duration(milliseconds: 400),
      onDismissed: (_) => isarService.deleteDiaryById(diary.id),
      confirmDismiss: (_) async =>
          await ConfirmDialog(
            title: l10n.areYouSureToDeleteTheDiary,
            summary: l10n.pleaseThinkTwiceAboutDeletingTheDiary,
            context: context,
          ).confirm ==
          ConfirmResult.confirm,
      child: Card(
        color: colorScheme.surfaceContainerLow.withOpacity(0.8),
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: InkWell(
          onTap: onTap ??
              () => context.push(
                    DiaryPageView(initialId: diary.id),
                  ),
          borderRadius: BorderRadius.circular(24.0),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(flex: 18, child: SizedBox()),
                Expanded(
                  flex: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Day(diary: diary),
                      _Weekday(diary: diary),
                    ],
                  ),
                ),
                Expanded(
                  flex: 142,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _EditAt(diary: diary),
                      _BelongTo(diary: diary),
                      _Content(diary: diary),
                    ],
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (diary.moodType != null)
                        _Mood(moodType: diary.moodType!),
                      if (diary.weatherType != null)
                        _Weather(weatherType: diary.weatherType!),
                    ],
                  ),
                ),
                const Expanded(flex: 9, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Mood extends StatelessWidget {
  const _Mood({required this.moodType});

  final DiaryMoodType moodType;

  @override
  Widget build(BuildContext context) {
    return Icon(size: 18, moodType.iconData);
  }
}

class _Weather extends StatelessWidget {
  const _Weather({required this.weatherType});

  final DiaryWeatherType weatherType;

  @override
  Widget build(BuildContext context) {
    return Icon(size: 18, weatherType.qweatherIcons.iconData);
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.document.plainText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: App.fontSize12),
    );
  }
}

class _BelongTo extends StatelessWidget {
  const _BelongTo({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.belongTo.format('y-M-d'),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: App.fontSize16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _EditAt extends StatelessWidget {
  const _EditAt({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.editAt.format('HH:mm:ss'),
      style: const TextStyle(
        fontSize: App.fontSize12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _Weekday extends StatelessWidget {
  const _Weekday({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).toLanguageTag();

    return Text(
      diary.belongTo.format(DateFormat.WEEKDAY, lang),
      style: const TextStyle(
        fontSize: App.fontSize10,
      ),
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.belongTo.format('dd'),
      style: const TextStyle(fontSize: App.fontSize24),
    );
  }
}
