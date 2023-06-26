import 'package:mercurius/index.dart';

class DiaryListViewCardWidget extends ConsumerWidget {
  const DiaryListViewCardWidget({
    super.key,
    required this.diary,
    this.dismissDirection = DismissDirection.endToStart,
    this.onTap,
  });

  final Diary diary;
  final DismissDirection dismissDirection;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MercuriusL10N l10n = MercuriusL10N.of(context);
    final String lang = Localizations.localeOf(context).toLanguageTag();

    final dayWidget = Text(
      diary.createDateTime.format('dd'),
      style: const TextStyle(
        fontSize: 24,
        fontFamily: 'Saira',
      ),
    );
    final weekdayWidget = Text(
      diary.createDateTime.format(DateFormat.WEEKDAY, lang),
      style: const TextStyle(
        fontSize: 10,
      ),
    );
    final latestEditTimeWidget = Text(
      diary.latestEditTime.format('HH:mm:ss'),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
    final createDateTimeWidget = Text(
      diary.titleString == ''
          ? diary.createDateTime.format('y-M-d')
          : diary.titleString,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
    final contentJsonStringWidget = Text(
      diary.plainText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
    final moodWidget = Icon(size: 18, diary.moodType.iconData);
    final weatherWidget =
        Icon(size: 18, diary.weatherType.qweatherIcons.iconData);

    return Dismissible(
      key: ValueKey(diary.id),
      direction: dismissDirection,
      movementDuration: const Duration(milliseconds: 400),
      onDismissed: (_) => isarService.deleteDiaryById(diary.id),
      confirmDismiss: (_) => MercuriusConfirmDialogWidget(
        title: l10n.areYouSureToDeleteTheDiary,
        summary: l10n.pleaseThinkTwiceAboutDeletingTheDiary,
        context: context,
      ).confirm,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: InkWell(
          onTap: onTap ??
              () async => {
                    Mercurius.vibration(ref: ref),
                    await showDialog<void>(
                      context: context,
                      builder: (context) => DiaryPageViewWidget(
                        diary: diary,
                      ),
                    )
                  },
          borderRadius: BorderRadius.circular(24.0),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 18, child: Container()),
                Expanded(
                  flex: 40,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [dayWidget, weekdayWidget],
                  ),
                ),
                Expanded(
                  flex: 142,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      latestEditTimeWidget,
                      createDateTimeWidget,
                      contentJsonStringWidget,
                    ],
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [moodWidget, weatherWidget],
                  ),
                ),
                Expanded(flex: 9, child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
