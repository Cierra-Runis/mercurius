import 'package:mercurius/index.dart';

class DiaryShareButton extends StatelessWidget {
  const DiaryShareButton({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = L10N.current;
    final lang = Localizations.localeOf(context).toLanguageTag();

    return IconButton(
      onPressed: () => Share.share(
        '${diary.createDateTime.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang)}\n'
        '${l10n.title} - ${diary.titleString == '' ? l10n.untitled : diary.titleString}\n'
        '${l10n.weather} - ${l10n.weatherText(diary.weatherType.weather)}\n'
        '${l10n.mood} - ${l10n.moodText(diary.moodType.mood)}\n'
        '--- ${l10n.content} ---\n'
        '${diary.document.toPlainText(EditorBody.embedBuilders, EditorBody.unknownEmbedBuilder)}',
      ),
      icon: const Icon(UniconsLine.share),
    );
  }
}
