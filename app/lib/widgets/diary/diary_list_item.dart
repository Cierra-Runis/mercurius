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
        color: colorScheme.surface.withOpacity(0.8),
        margin: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: InkWell(
          onTap: onTap ??
              () => context.pushDialog(
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
                      _CreateAt(diary: diary),
                      _Content(diary: diary),
                    ],
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Mood(diary: diary),
                      _Weather(diary: diary),
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

class _Weather extends StatelessWidget {
  const _Weather({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Icon(size: 18, diary.weatherType.qweatherIcons.iconData);
  }
}

class _Mood extends StatelessWidget {
  const _Mood({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Icon(size: 18, diary.moodType.iconData);
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.document.toPlainText(
        EditorBody.embedBuilders,
        EditorBody.unknownEmbedBuilder,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class _CreateAt extends StatelessWidget {
  const _CreateAt({required this.diary});

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    return Text(
      diary.title.isEmpty ? diary.createAt.format('y-M-d') : diary.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
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
        fontSize: 12,
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
      diary.createAt.format(DateFormat.WEEKDAY, lang),
      style: const TextStyle(
        fontSize: 10,
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
      diary.createAt.format('dd'),
      style: const TextStyle(
        fontSize: 24,
        fontFamily: App.fontSaira,
      ),
    );
  }
}
