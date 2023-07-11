import 'package:mercurius/index.dart';

class DiaryPageViewShareButtonWidget extends StatelessWidget {
  const DiaryPageViewShareButtonWidget({
    super.key,
    required this.ref,
    required this.diary,
    required this.lang,
    required this.l10n,
  });

  final WidgetRef ref;
  final Diary diary;
  final String lang;
  final MercuriusL10N l10n;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Mercurius.vibration(ref: ref);
        await Share.share(
          '${diary.createDateTime.format(DateFormat.YEAR_ABBR_MONTH_DAY, lang)}\n'
          '${l10n.title} - ${diary.titleString == '' ? l10n.untitled : diary.titleString}\n'
          '${l10n.weather} - ${l10n.weatherText(diary.weatherType.weather)}\n'
          '${l10n.mood} - ${l10n.moodText(diary.moodType.mood)}\n'
          '--- ${l10n.content} ---\n'
          '${diary.document.toPlainText(DiaryEditorBodyWidget.embedBuilders)}',
        );
      },
      icon: const Icon(UniconsLine.share),
    );
  }
}
