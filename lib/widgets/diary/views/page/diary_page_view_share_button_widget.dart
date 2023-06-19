import 'package:mercurius/index.dart';

class DiaryPageViewShareButtonWidget extends StatelessWidget {
  const DiaryPageViewShareButtonWidget({
    super.key,
    required this.ref,
    required this.diary,
    required this.lang,
    required this.localizations,
  });

  final WidgetRef ref;
  final Diary diary;
  final String lang;
  final S localizations;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Mercurius.vibration(ref: ref);
        await Share.share(
          '${diary.createDateTime.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang)}\n'
          '${localizations.weather} - ${diary.weatherType.weather}\n'
          '${localizations.title} - ${diary.titleString == '' ? localizations.untitled : diary.titleString}\n'
          '${localizations.mood} - ${localizations.moodText(diary.moodType.mood)}\n'
          '--- ${localizations.content} ---\n'
          '${diary.document.toPlainText()}',
        );
      },
      icon: const Icon(UniconsLine.share),
    );
  }
}
