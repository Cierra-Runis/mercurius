import 'package:mercurius/index.dart';

class DiaryPageItemShareButtonWidget extends StatelessWidget {
  const DiaryPageItemShareButtonWidget({
    super.key,
    required this.diary,
  });

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final lang = Localizations.localeOf(context).toLanguageTag();

    return IconButton(
      onPressed: () => Share.share(
        '${diary.createDateTime.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang)}\n'
        '${l10n.title} - ${diary.titleString == '' ? l10n.untitled : diary.titleString}\n'
        '${l10n.weather} - ${l10n.weatherText(diary.weatherType.weather)}\n'
        '${l10n.mood} - ${l10n.moodText(diary.moodType.mood)}\n'
        '--- ${l10n.content} ---\n'
        '${diary.document.toPlainText(EditorBodyWidget.embedBuilders, EditorBodyWidget.unknownEmbedBuilder)}',
      ),
      icon: const Icon(UniconsLine.share),
    );
  }
}
